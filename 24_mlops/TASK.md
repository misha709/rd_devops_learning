# Building an AI Service for Customer Support

## Goal

Develop a simple AI service to answer user questions using two different architectures:

1. **SaaS LLM API** - Using external API services
2. **Self-hosted model (CPU)** - Running models locally

After implementation, deploy the service in containers or Kubernetes and analyze the differences between the approaches.

---

## Part 1: SaaS LLM API Integration

Create an API service that calls an LLM through an external API.

### Supported LLM Providers

You can use any of the following:

- **Gemini** (recommended due to available free limits)
- OpenAI
- Anthropic
- Any other LLM provider of your choice

### API Specification

The service should expose the following endpoint:

#### Endpoint: `POST /ask`

**Request Body:**
```json
{
  "question": "How do I reset my password?"
}
```

**Response Body:**
```json
{
  "answer": "To reset your password..."
}
```

### Additional Requirements (Optional)

Enhance your service with:

- Retry logic for failed requests
- Timeout handling
- Request/response logging

---

## Part 2: Self-Hosted Model (CPU)

Reuse the service created in Part 1 and integrate it with a model deployed locally on your computer.

### Option 1: Using Ollama (Recommended)

Run a local model using Ollama:

```bash
ollama run phi3
```

or

```bash
ollama run mistral
```

### Option 2: Hugging Face Models

Use any desired model from Hugging Face.

### Alternative: Using n8n

As an alternative to the API service, you can use **n8n** as an orchestration backend.

---

## Expected Results

You should have a complete solution that can be used as a chatbot to build a product support feature, with:

- Working API endpoint for asking questions
- Integration with either SaaS LLM or self-hosted model
- Containerized deployment (Docker/Kubernetes)
- Analysis of differences between the two approaches