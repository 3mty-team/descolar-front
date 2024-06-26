import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/core/errors/failure.dart';

class CreateMessage {
  final MessagesRepository messageRepository;

  CreateMessage({required this.messageRepository});

  Future<Either<Failure, void>> call({
    required CreateMessageParams params,
  }) async {
    return await messageRepository.createMessage(params: params);
  }
}
