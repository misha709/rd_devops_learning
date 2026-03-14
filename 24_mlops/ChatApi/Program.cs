using ChatApi.Models;
using ChatApi.Services;

var builder = WebApplication.CreateBuilder(args);

var aiProvider = builder.Configuration["AiProvider"]
    ?? throw new InvalidOperationException("AiProvider is not configured. Set 'AiProvider' to 'Gemini' or 'Ollama' in appsettings.");

switch (aiProvider.ToLowerInvariant())
{
    case "gemini":
        builder.Services.AddHttpClient<IAiService, GeminiService>();
        break;
    case "ollama":
        builder.Services.AddHttpClient<IAiService, OllamaService>();
        break;
    default:
        throw new InvalidOperationException($"Unknown AiProvider '{aiProvider}'. Valid values are 'Gemini' or 'Ollama'.");
}

builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new { status = "healthy" }))
    .WithName("HealthCheck");

app.MapPost("/ask", async (AskRequest request, IAiService aiService, ILogger<Program> logger) =>
{
    if (string.IsNullOrWhiteSpace(request.Question))
    {
        return Results.BadRequest(new { error = "question field is required" });
    }

    logger.LogInformation("Received question: {Question}", request.Question);

    try
    {
        var answer = await aiService.AskQuestionAsync(request.Question);
        logger.LogInformation("Generated answer successfully");
        
        return Results.Ok(new AskResponse { Answer = answer });
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error processing question");
        return Results.Problem("Failed to get response from AI");
    }
})
.WithName("AskQuestion");

app.Run();
