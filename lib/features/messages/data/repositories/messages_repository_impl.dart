import 'package:dartz/dartz.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/features/messages/business/repositories/message_repository.dart';
import 'package:descolar_front/features/messages/data/datasources/messages_local_data_source.dart';
import 'package:descolar_front/features/messages/data/models/conversation_model.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_item.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesLocalDataSource localDataSource;

  MessagesRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, MessageEntity>> createMessage({required CreateMessageParams params}) {
    // TODO: implement createMessage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteMessage({required int messageId}) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getConversationInRange({required String userUuid, required int range}) {
    // TODO: implement getConversationInRange
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ConversationModel>>> getConversations() async {
    try {
      List<ConversationModel> conversations = await localDataSource.getConversations();
      return Right(conversations);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'Erreur'));
    }
  }

  @override
  Future<Either<Failure, bool>> likeMessage({required int messageId}) {
    // TODO: implement likeMessage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> unlikeMessage({required int messageId}) {
    // TODO: implement unlikeMessage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> setConversationToCache(ConversationEntity conversation) async {
    try {
      ConversationModel conversationModel = ConversationModel(
        receiver: conversation.receiver,
        messagePreview: conversation.messagePreview,
        iat: conversation.iat,
      );
      bool isOk = await localDataSource.cacheConversation(conversationModel);
      return Right(isOk);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'Erreur'));
    }
  }
}
