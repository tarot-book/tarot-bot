// lib/bot.dart
import 'package:tarot_bot/logger.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

Future<void> handleStartCommand(
  Telegram telegram,
  Map<String, dynamic> message,
  String? webAppUrl,
) async {
  final chatId = message['chat']['id'];
  final from = message['from']?['username'] ?? 'unknown';
  logger.i('/start command received from @$from');

  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final baseUrl = webAppUrl ?? 'https://app.tarot.ru';
  final versionedUrl = '$baseUrl?v=$timestamp';

  final replyMarkup = InlineKeyboardMarkup(
    inlineKeyboard: [
      [
        InlineKeyboardButton(
          text: 'Открыть Азбуку Таро',
          webApp: WebAppInfo(url: versionedUrl),
        )
      ]
    ],
  );

  await telegram.sendMessage(
    chatId,
    'Добро пожаловать! Нажмите кнопку, чтобы открыть "Азбуку Таро".',
    replyMarkup: replyMarkup,
  );
}
