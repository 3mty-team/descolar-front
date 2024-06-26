import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_item.dart';

class GetConversations {
  final MessagesRepository messageRepository;

  GetConversations({required this.messageRepository});

  Future<Either<Failure, void>> call({required ConversationEntity conversation}) async {
    return await messageRepository.setConversationToCache(conversation);
  }
}