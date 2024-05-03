import 'package:dio/dio.dart';

import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/data/models/comment_model.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/constants/constants.dart';

abstract class CommentRemoteDateSource {
  Future<CommentModel> createComment({required CreateCommentParams params});

  Future<bool> deleteComment({required CommentEntity comment});

  Future<List<CommentModel>> getAllCommentsInRange({required PostEntity post, required int range});
}

class CommentRemoteDateSourceImpl implements CommentRemoteDateSource {
  final Dio dio;

  CommentRemoteDateSourceImpl({required this.dio});

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
  Future<CommentModel> createComment({required CreateCommentParams params}) async {
    int postID = params.post.postId;
    final response = await dio.post(
      '$baseDescolarApi/post/$postID/comment',
      data: FormData.fromMap({
        'content': params.content,
        'send_timestamp': params.commentDate,
      }),
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      return CommentModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteComment({required CommentEntity comment}) async {
    int commentID = comment.commentID;
    final response = await dio.delete(
      '$baseDescolarApi/post/$commentID/comment',
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      CachedPost.loadedComments.clear();
      return response.data['comment'] != null;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CommentModel>> getAllCommentsInRange({required PostEntity post, required int range}) async {
    int postID = post.postId;
    final response = await dio.get(
      '$baseDescolarApi/post/comment/$postID/$range',
      options: _getRequestOptions(),
    );
    if (response.statusCode == 200) {
      CachedPost.loadedComments.clear();
      response.data.forEach((comment) {
        CachedPost.loadedComments.add(CommentModel.fromJson(json: comment));
      });
      return CachedPost.loadedComments;
    } else {
      throw ServerException();
    }
  }
}
