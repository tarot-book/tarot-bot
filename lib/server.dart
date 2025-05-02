// lib/server.dart
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:tarot_bot/logger.dart';
import 'package:teledart/telegram.dart';
import 'bot.dart';

Future<void> startWebhookServer(
  Telegram telegram,
  int port,
  String path,
  String? webAppUrl,
) async {
  logger.i('Starting webhook server...');
  final router = Router();
  logger.i('Webhook path registered: $path');
  router.post(path, (Request request) async {
    final payload = await request.readAsString();
    final json = jsonDecode(payload) as Map<String, dynamic>;
    logger.i('Webhook update received');

    final message = json['message'] ?? json['edited_message'];
    if (message != null && message['text'] == '/start') {
      await handleStartCommand(telegram, message, webAppUrl);
    }

    return Response.ok('ok');
  });
  router.get(path, (Request request) {
    logger.i(
      'Received GET request on webhook path (possibly from Telegram check)',
    );
    return Response.ok('ok');
  });
  router.all('/<ignored|.*>', (Request request) {
    logger.w('⚠️ Unknown route: ${request.url}');
    return Response.notFound('Route not found');
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await io.serve(handler, InternetAddress.anyIPv4, port);
  logger.i('Webhook server listening on port ${server.port}');
}
