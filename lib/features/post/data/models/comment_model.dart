import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required int commentID,
    required String userID,
    required PostModel post,
    required String content,
    required String username,
    required DateTime commentDate,
    String? authorPfp,
  }) : super(
          commentID: commentID,
          userID: userID,
          post: post,
          content: content,
          username: username,
          commentDate: commentDate,
          authorPfp: authorPfp,
        );

  factory CommentModel.fromJson({required Map<String, dynamic> json, CommentModel? repostedPost}) {
    Map<String, dynamic> user = json['user'];
    Map<String, dynamic> date = json['date'];
    return CommentModel(
      commentID: json['id'],
      userID: user['uuid'],
      username: user['username'],
      content: json['content'],
      commentDate: stringToDatetime(date['date']),
      post: PostModel.fromJson(json: json['post']),
      authorPfp: user['pfpPath'],
    );
  }
}
