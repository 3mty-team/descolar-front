import 'package:descolar_front/features/messages/presentation/widgets/message_item.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  Map<String, List<MessageItem>> messages = {};

  void sendMessage(String message, String receiverUUID, bool isSentByCurrentUser) {
    MessageItem msgItem = MessageItem(messageText: message, isSentByCurrentUser: isSentByCurrentUser);

    if (!messages.containsKey(receiverUUID)) {
      messages[receiverUUID] = [];
    }

    messages[receiverUUID]?.add(msgItem);

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );

    notifyListeners();
  }
}
