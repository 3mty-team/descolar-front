import 'package:dartz/dartz.dart';

import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/core/errors/failure.dart';

class DeleteMessage {
  final MessageRepository messageRepository;

  DeleteMessage({required this.messageRepository});

  Future<Either<Failure, bool>> call({
    required int messageId,
  }) async {
    return await messageRepository.deleteMessage(messageId: messageId);
  }
}
