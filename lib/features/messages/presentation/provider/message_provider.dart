import 'package:descolar_front/features/messages/presentation/widgets/message_item.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageItem> messages = [];

  void sendMessage(String message, bool isSentByCurrentUser) {
    MessageItem msgItem = MessageItem(messageText: message, isSentByCurrentUser: isSentByCurrentUser);
    messages.add(msgItem);
    notifyListeners();
  }
}
