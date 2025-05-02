// bin/main.dart
import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:tarot_bot/server.dart';
import 'package:tarot_bot/logger.dart';
import 'package:teledart/telegram.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

void main() async {
  // Disable stdout buffering for real-time log visibility
  stdout.nonBlocking;
  stdout.writeCharCode(0); // optional kickstart


  logger.d('logger.d is working');

  final token = env['BOT_TOKEN'];
  final port = int.tryParse(env['PORT'] ?? '3010') ?? 3010;
  final path = env['WEBHOOK_PATH'] ?? '/webhook';
  final webAppUrl = env['WEBAPP_URL'];

  if (token == null || token.isEmpty) {
    logger.e('BOT_TOKEN is not set in .env or system environment');
    exit(1);
  }

  final telegram = Telegram(token);
  await startWebhookServer(telegram, port, path, webAppUrl);
}
