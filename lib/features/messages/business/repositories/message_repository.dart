import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/connection/network_info.dart';

import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/messages/data/datasources/messages_local_data_source.dart';
import 'package:descolar_front/features/messages/data/datasources/messages_remote_data_source.dart';
import 'package:descolar_front/features/messages/data/repositories/messages_repository_impl.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_item.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MessagesRepository {
  static Future<MessagesRepositoryImpl> getMessagesRepository() async {
    return MessagesRepositoryImpl(
      localDataSource: MessagesLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance()),
      remoteDataSource: MessagesRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
  }

  Future<Either<Failure, void>> createMessage({
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

  Future<Either<Failure, List<MessageEntity>>> getMessagesInRange({
    required String userUuid,
    required int range,
  });

  Future<Either<Failure, List<ConversationEntity>>> getConversations();

  Future<Either<Failure, void>> setConversationToCache(ConversationEntity conversation);
}
