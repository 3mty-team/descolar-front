import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/features/messages/business/usecases/get_conversations.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_item.dart';
import 'package:descolar_front/features/messages/presentation/widgets/message_item.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  Map<String, List<MessageItem>> messages = {};
  List<ConversationEntity> conversations = [];

  void sendMessage(String message, String receiverUUID, bool isSentByCurrentUser) async {
    MessagesRepository repository = await MessagesRepository.getMessagesRepository();
    UserProfilRepository userProfilRepository = await UserProfilRepository.getUserProfilRepository();
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

    // TODO : use endpoint to create msg to db

    // TODO : set current conversation to cache
    ConversationEntity? currentConversation;
    for (ConversationEntity conversation in conversations) {
      if (conversation.receiver.uuid == receiverUUID) {
        currentConversation = conversation;
        break;
      }
    }

    if (currentConversation == null) {
      final failureOrUserProfilEntity = await userProfilRepository.getUserProfil(uuid: receiverUUID);
      await failureOrUserProfilEntity.fold(
        (Failure failure) {
          print('FAIL USER PROFIL ');
        },
        (UserProfilEntity userProfilEntity) {
          currentConversation = ConversationEntity(receiver: userProfilEntity);
        },
      );
    }

    repository.setConversationToCache(currentConversation!);

    notifyListeners();
  }

  void getConversationFromCache() async {
    MessagesRepository repository = await MessagesRepository.getMessagesRepository();

    final failureOrConversations = await GetConversations(messageRepository: repository).call();

    await failureOrConversations.fold(
      (Failure failure) {
        print('FAIL CONVERSATIONS CACHE');
      },
      (List<ConversationEntity> conversations) {
        for (ConversationEntity conversation in conversations) {
          print(conversation.receiver.username);
        }
        this.conversations = conversations;
      },
    );
  }
}
