import 'package:dartz/dartz.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/core/errors/failure.dart';

abstract class MessageRepository {
  Future<Either<Failure, MessageEntity>> createMessage({
    required CreateMessageParams params,
  });

  Future<Either<Failure, bool>> deleteMessage({
    required int messageId,
  });

  Future<Either<Failure, bool>> likeMessage({
    required int messageId,
  });

  Future<Either<Failure, bool>> unlikeMessage({
    required int messageId,
  });

  Future<Either<Failure, List<MessageEntity>>> getConversationInRange({
    required String userUuid,
    required int range,
  });
}
