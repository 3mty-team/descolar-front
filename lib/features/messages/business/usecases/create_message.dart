import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/core/errors/failure.dart';

class CreateMessage {
  final MessageRepository messageRepository;

  CreateMessage({required this.messageRepository});

  Future<Either<Failure, MessageEntity>> call({
    required CreateMessageParams params,
  }) async {
    return await messageRepository.createMessage(params: params);
  }
}
