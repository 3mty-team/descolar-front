import 'package:dartz/dartz.dart';

import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/core/errors/failure.dart';

class GetConversations {
  final MessagesRepository messageRepository;

  GetConversations({required this.messageRepository});

  Future<Either<Failure, List<ConversationEntity>>> call() async {
    return await messageRepository.getConversations();
  }
}
