using System.Text.Json;
using System.Text.Json.Serialization;

namespace ChatApi.Services;

public class OllamaService : IAiService
{
    private readonly HttpClient _httpClient;
    private readonly ILogger<OllamaService> _logger;
    private readonly string _baseUrl;
    private readonly string _model;
    private const int MaxRetries = 3;
    private const int TimeoutSeconds = 60;

    public OllamaService(HttpClient httpClient, IConfiguration configuration, ILogger<OllamaService> logger)
    {
        _httpClient = httpClient;
        _logger = logger;
        _baseUrl = configuration["Ollama:Url"]
            ?? throw new InvalidOperationException("Ollama URL is not configured. Set 'Ollama:Url' in appsettings.");
        _model = configuration["Ollama:Model"]
            ?? throw new InvalidOperationException("Ollama model is not configured. Set 'Ollama:Model' in appsettings.");
        _httpClient.Timeout = TimeSpan.FromSeconds(TimeoutSeconds);
    }

    public async Task<string> AskQuestionAsync(string question, CancellationToken cancellationToken = default)
    {
        var prompt = $"You are a helpful customer support assistant. Answer the following question clearly and concisely:\n\n{question}";

        var request = new
        {
            model = _model,
            prompt = prompt,
            stream = false
        };

        Exception? lastException = null;

        for (var attempt = 0; attempt < MaxRetries; attempt++)
        {
            if (attempt > 0)
            {
                _logger.LogWarning("Retrying Ollama API call, attempt {Attempt}/{MaxRetries}", attempt + 1, MaxRetries);
                await Task.Delay(TimeSpan.FromSeconds(attempt), cancellationToken);
            }

            try
            {
                _logger.LogInformation("Calling Ollama API, attempt {Attempt}/{MaxRetries}", attempt + 1, MaxRetries);

                var response = await _httpClient.PostAsJsonAsync(
                    $"{_baseUrl}/api/generate",
                    request,
                    cancellationToken);

                var responseBody = await response.Content.ReadAsStringAsync(cancellationToken);

                if (!response.IsSuccessStatusCode)
                {
                    _logger.LogError("Ollama API error: {StatusCode} - {Response}", response.StatusCode, responseBody);
                    lastException = new HttpRequestException($"API returned {response.StatusCode}: {responseBody}");
                    continue;
                }

                var ollamaResponse = JsonSerializer.Deserialize<OllamaResponse>(responseBody);

                if (!string.IsNullOrWhiteSpace(ollamaResponse?.Response))
                {
                    _logger.LogInformation("Successfully received answer from Ollama API");
                    return ollamaResponse.Response;
                }

                lastException = new InvalidOperationException("Empty response from Ollama API");
                _logger.LogWarning("Empty response from Ollama API");
            }
            catch (OperationCanceledException)
            {
                _logger.LogWarning("Request cancelled");
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error calling Ollama API");
                lastException = ex;
            }
        }

        throw new InvalidOperationException($"Failed to get answer after {MaxRetries} retries", lastException);
    }
}

internal class OllamaResponse
{
    [JsonPropertyName("response")]
    public string? Response { get; set; }

    [JsonPropertyName("done")]
    public bool Done { get; set; }

    [JsonPropertyName("model")]
    public string? Model { get; set; }
}