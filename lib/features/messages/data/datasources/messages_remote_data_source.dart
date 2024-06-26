import 'package:descolar_front/core/constants/constants.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/messages/data/models/message_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/user_info.dart';

abstract class MessagesRemoteDataSource {
  Future<void> createMessage({required CreateMessageParams params});

  Future<List<MessageModel>> getMessages({required String userUuid, required int range});
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final Dio dio;

  MessagesRemoteDataSourceImpl({required this.dio});

  Options _getRequestOptions() {
    return Options(
      headers: {
        'Authorization': 'Bearer ${UserInfo.token}',
      },
      followRedirects: false,
      validateStatus: (status) => status! < 500,
    );
  }

  @override
  Future<void> createMessage({required CreateMessageParams params}) async {
    final response = await dio.post(
      '$baseDescolarApi/message',
      data: FormData.fromMap({
        'receiver_uuid': params.receiverUuid,
        'content': params.content,
        'send_timestamp': params.iat ~/ 1000,
        'medias': [],
      }),
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      return Future(() => true);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MessageModel>> getMessages({required String userUuid, required int range}) async {
    List<MessageModel> messages = [];

    final response = await dio.get(
      '$baseDescolarApi/message/conversation/$userUuid/$range',
      options: _getRequestOptions(),
    );

    if (response.statusCode == 200) {
      for (final messageJson in response.data) {
        messages.add(MessageModel.fromJson(json: messageJson));
      }
      return messages;
    }
    throw ServerException();
  }
}
