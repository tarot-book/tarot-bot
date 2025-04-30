#!/bin/bash

# Load .env if it exists
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Check required variables
if [[ -z "$BOT_TOKEN" || -z "$WEBHOOK_URL" ]]; then
  echo "❌ BOT_TOKEN and WEBHOOK_URL must be set in environment or .env file."
  exit 1
fi

# Set webhook URL for Telegram bot
echo "📡 Setting webhook to ${WEBHOOK_URL}${WEBHOOK_PATH}..."
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/setWebhook" \
  -d "url=${WEBHOOK_URL}${WEBHOOK_PATH}" && echo "✅ Webhook set."
