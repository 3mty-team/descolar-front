import 'package:dartz/dartz.dart';

import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/core/errors/failure.dart';

class GetMessagesInRange {
  final MessagesRepository messageRepository;

  GetMessagesInRange({required this.messageRepository});

  Future<Either<Failure, List<MessageEntity>>> call({
    required String userUuid,
    required int range,
  }) async {
    return await messageRepository.getMessagesInRange(userUuid: userUuid, range: range);
  }
}
