# Define variables for clarity (optional, but recommended)
API_URL="https://apim.datalab-01.azure.grid.rws.nl/openai/deployments/gpt-5/chat/completions"
API_VERSION="2025-01-01-preview"

curl -X POST \
  "${API_URL}?api-version=${API_VERSION}" \
  -H "Content-Type: application/json" \
  -H "Authorization: ${AUTHORIZATION}" \
  -d '{
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful assistant for testing API connectivity. Respond with only the word \"SUCCESS\"."
      },
      {
        "role": "user",
        "content": "Test"
      }
    ],
    "max_completion_tokens": 10
  }'
