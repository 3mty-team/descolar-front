import 'dart:ffi';

import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/features/messages/business/usecases/create_message.dart';
import 'package:descolar_front/features/messages/business/usecases/get_conversations.dart';
import 'package:descolar_front/features/messages/business/usecases/get_messages_in_range.dart';
import 'package:descolar_front/features/messages/presentation/widgets/message_item.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';
import 'package:descolar_front/features/profil/business/usecases/get_user_profil.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  Map<String, List<MessageItem>> messages = {};
  List<ConversationEntity> conversations = [];

  void sendMessage(String message, String otherUserUUID, bool isSentByCurrentUser, int iat) async {
    MessagesRepository messageRepository = await MessagesRepository.getMessagesRepository();
    UserProfilRepository userProfilRepository = await UserProfilRepository.getUserProfilRepository();
    MessageItem msgItem = MessageItem(messageText: message, isSentByCurrentUser: isSentByCurrentUser);

    if (!messages.containsKey(otherUserUUID)) {
      messages[otherUserUUID] = [];
    }

    messages[otherUserUUID]?.add(msgItem);

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );

    // Create message in db
    if (isSentByCurrentUser) {
      await CreateMessage(messageRepository: messageRepository).call(
        params: CreateMessageParams(
          receiverUuid: otherUserUUID,
          content: message,
          iat: iat,
        ),
      );
    }


    // Cache conversation
    final failureOrUserProfilEntity = await GetUserProfil(userProfilRepository: userProfilRepository).call(uuid: otherUserUUID);
    await failureOrUserProfilEntity.fold(
      (Failure failure) {
        print('FAIL USER PROFIL ');
      },
      (UserProfilEntity userProfilEntity) {
        messageRepository.setConversationToCache(
          ConversationEntity(
            receiver: userProfilEntity,
            messagePreview: message,
            iat: iat,
          ),
        );
      },
    );

    await getConversationFromCache();

    notifyListeners();
  }

  void getMessagesFromDB(String receiverUUID) async {
    MessagesRepository repository = await MessagesRepository.getMessagesRepository();

    final failureOrMessages = await GetMessagesInRange(messageRepository: repository).call(userUuid: receiverUUID, range: 100);

    await failureOrMessages.fold(
      (Failure failure) {
        print('FAIL GET MESSAGES FROM DB');
      },
      (List<MessageEntity> messagesEntity) {
        for (MessageEntity m in messagesEntity) {
          print('${m.sender.username} --> ${m.receiver.username} : ${m.content}');
          print('${m.sender.uuid} : ${UserInfo.user.uuid}');
        }
        messages[receiverUUID] = messagesEntity
            .map(
              (messageEntity) => MessageItem(
                messageText: messageEntity.content,
                isSentByCurrentUser: messageEntity.sender.uuid == UserInfo.user.uuid,
              ),
            )
            .toList();
        notifyListeners();
      },
    );

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );

    notifyListeners();
  }

  Future<void> getConversationFromCache() async {
    MessagesRepository repository = await MessagesRepository.getMessagesRepository();

    final failureOrConversations = await GetConversations(messageRepository: repository).call();

    await failureOrConversations.fold(
      (Failure failure) {
        print('FAIL GET CONVERSATIONS FROM CACHE');
      },
      (List<ConversationEntity> conversations) {
        this.conversations = conversations;
        notifyListeners();
      },
    );
    notifyListeners();
  }
}
