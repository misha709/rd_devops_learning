using ChatApi.Models;
using System.Text;
using System.Text.Json;

namespace ChatApi.Services;

public interface IAiService
{
    Task<string> AskQuestionAsync(string question, CancellationToken cancellationToken = default);
}

public class GeminiService : IAiService
{
    private readonly HttpClient _httpClient;
    private readonly ILogger<GeminiService> _logger;
    private readonly string _apiUrl;
    private readonly string _apiKey;
    private const int MaxRetries = 3;
    private const int TimeoutSeconds = 30;

    public GeminiService(HttpClient httpClient, IConfiguration configuration, ILogger<GeminiService> logger)
    {
        _httpClient = httpClient;
        _logger = logger;
        _apiUrl = configuration["Gemini:Url"] 
            ?? throw new InvalidOperationException("Gemini API key is not configured");
        
        _apiKey = configuration["Gemini:ApiKey"] 
            ?? throw new InvalidOperationException("Gemini API key is not configured");
        
        _httpClient.Timeout = TimeSpan.FromSeconds(TimeoutSeconds);
    }

    public async Task<string> AskQuestionAsync(string question, CancellationToken cancellationToken = default)
    {
        var prompt = $"You are a helpful customer support assistant. Answer the following question clearly and concisely:\n\n{question}";
        
        var request = new GeminiRequest
        {
            Contents =
            [
                new Content
                {
                    Parts = [new Part { Text = prompt }]
                }
            ]
        };

        Exception? lastException = null;
        
        for (int attempt = 0; attempt < MaxRetries; attempt++)
        {
            if (attempt > 0)
            {
                _logger.LogWarning("Retrying Gemini API call, attempt {Attempt}/{MaxRetries}", attempt + 1, MaxRetries);
                await Task.Delay(TimeSpan.FromSeconds(attempt), cancellationToken);
            }

            try
            {
                var json = JsonSerializer.Serialize(request);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                using var requestMessage = new HttpRequestMessage(HttpMethod.Post, _apiUrl);
                requestMessage.Content = content;
                requestMessage.Headers.Add("X-goog-api-key", _apiKey);

                _logger.LogInformation("Calling Gemini API, attempt {Attempt}/{MaxRetries}", attempt + 1, MaxRetries);
                
                var response = await _httpClient.SendAsync(requestMessage, cancellationToken);
                
                var responseBody = await response.Content.ReadAsStringAsync(cancellationToken);
                
                if (!response.IsSuccessStatusCode)
                {
                    _logger.LogError("Gemini API error: {StatusCode} - {Response}", response.StatusCode, responseBody);
                    lastException = new HttpRequestException($"API returned {response.StatusCode}: {responseBody}");
                    continue;
                }

                var geminiResponse = JsonSerializer.Deserialize<GeminiResponse>(responseBody);
                
                if (geminiResponse?.Candidates?.Count > 0 && 
                    geminiResponse.Candidates[0].Content?.Parts?.Count > 0)
                {
                    var answer = geminiResponse.Candidates[0].Content.Parts[0].Text;
                    _logger.LogInformation("Successfully received answer from Gemini API");
                    return answer;
                }

                lastException = new InvalidOperationException("No answer in Gemini response");
                _logger.LogWarning("Empty response from Gemini API");
            }
            catch (OperationCanceledException)
            {
                _logger.LogWarning("Request cancelled");
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error calling Gemini API");
                lastException = ex;
            }
        }

        throw new InvalidOperationException($"Failed to get answer after {MaxRetries} retries", lastException);
    }
}
