# Building an AI Service for Customer Support

A simple AI-powered customer support service built with ASP.NET Core, implementing integration with Google Gemini API.

## Features

- RESTful API with `/ask` endpoint
- Integration with Google Gemini API
- Retry logic with exponential backoff (3 attempts)
- Request timeout handling (30 seconds)
- Comprehensive request/response logging
- Docker containerization ready
- Health check endpoint

## Prerequisites

- .NET 10.0 SDK
- Gemini API key (get from [Google AI Studio](https://makersuite.google.com/app/apikey))
- Docker (optional, for containerization)

## Setup

### 1. Navigate to Project

```powershell
cd 24_mlops\ChatApi
```

### 2. Configure API Key

Edit `appsettings.json` and add your Gemini API key:

```json
{
  "Gemini": {
    "ApiKey": "your_actual_api_key_here"
  }
}
```

Or use environment variable (recommended for production):

```powershell
# PowerShell
$env:Gemini__ApiKey = "your_api_key_here"
```

### 3. Run Locally

```powershell
dotnet run
```

The service will start on `https://localhost:5001`

## Usage

### Health Check

```
curl https://localhost:5001/health
```
![Health check response](./images/healthcheck.png)

### Ask a Question

```bash
curl -X POST https://localhost:5001/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "How do I reset my password?"}'
```

![Gemini response](./images/gemini_response.png)

## Docker Deployment

### Build and Run with Docker

```powershell
# Navigate to project root
cd 24_mlops

# Build the image
docker build -t chatapi -f ChatApi/Dockerfile ChatApi/

# Run the container
docker run -p 8080:8080 -e Gemini__ApiKey=your_api_key_here chatapi
```