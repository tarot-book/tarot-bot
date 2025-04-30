// lib/bot.dart
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';
import 'package:logger/logger.dart';

final logger = Logger();

Future<void> handleStartCommand(
  Telegram telegram,
  Map<String, dynamic> message,
  String? webAppUrl,
) async {
  final chatId = message['chat']['id'];
  final from = message['from']?['username'] ?? 'unknown';
  logger.i('/start command received from @$from');

  final replyMarkup = InlineKeyboardMarkup(
    inlineKeyboard: [
      [
        InlineKeyboardButton(
          text: 'Открыть Азбуку Таро',
          webApp: WebAppInfo(url: webAppUrl ?? 'https://app.tarot.ru'),
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
