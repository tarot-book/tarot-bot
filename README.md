# 🔙 Tarot Bot

A lightweight Telegram bot that launches a Flutter-based mini-app for Tarot card reference and learning.

## ✨ Features

- Starts a [Telegram Mini App](https://app.tarot.ru) via inline button
- Handles webhook updates securely via HTTPS
- Minimal, test-covered server in Dart using `shelf` and `shelf_router`
- CI/CD pipeline with GitHub Actions and deploy to your server
- Supports `.env` configuration and works well with [ngrok](https://ngrok.com)

## 📦 Stack

- Language: Dart (>=3.0)
- Server: `shelf`, `shelf_router`
- Telegram API: `teledart`
- Tests: `package:test`
- CI/CD: GitHub Actions
- Deployment: systemd + SSH

## 🚀 Getting Started

### 1. Clone & Install

```bash
git clone https://github.com/your-username/tarot-bot.git
cd tarot-bot
dart pub get
```

### 2. Configure

Create `.env` file:

```env
BOT_TOKEN=your-telegram-token
WEBHOOK_URL=https://your-url.ngrok.io
WEBHOOK_PATH=/webhook
PORT=3010
WEBAPP_URL=https://app.tarot.ru
```

### 3. Start locally

```bash
dart run bin/main.dart
```

Then run `ngrok`:

```bash
ngrok http 3010
```

### 4. Register webhook

```bash
./set_webhook.sh
```

## ✅ Testing

```bash
dart test
```

## 🛠️ Deployment

Set up GitHub secrets: `SSH_HOST`, `SSH_USER`, `SSH_PRIVATE_KEY`, and `SERVER_PATH`.

Deploy automatically on push to `main` or `v*` tag via GitHub Actions.

## 📄 License

MIT
