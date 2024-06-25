import 'package:descolar_front/features/messages/presentation/widgets/message_item.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  List<MessageItem> messages = [];

  void sendMessage(String message, bool isSentByCurrentUser) {
    MessageItem msgItem = MessageItem(messageText: message, isSentByCurrentUser: isSentByCurrentUser);
    messages.add(msgItem);
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    notifyListeners();
  }
}
