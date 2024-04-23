import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required int postId,
    required String userId,
    required String username,
    required String content,
    required DateTime postDate,
    required int likes,
    required int comments,
    required bool isLiked,
  }) : super(
          postId: postId,
          userId: userId,
          username: username,
          content: content,
          postDate: postDate,
          likes: likes,
          comments: comments,
          isLiked: isLiked,
        );

  factory PostModel.fromJson({required Map<String, dynamic> json}) {
    Map<String, dynamic> user = json['user'];
    Map<String, dynamic> date = json['date'];
    return PostModel(
      postId: json['id'],
      userId: user['uuid'],
      username: user['username'],
      content: json['content'],
      postDate: stringToDatetime(date['date']),
      likes: json['likes'],
      comments: json['comments'],
      isLiked: json['content'] == null, //TODO: Check liked post of current user
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'username': username,
      'content': content,
      'postDate': postDate.toString(),
      'likes': likes,
      'comments': comments,
    };
  }
}
