import 'package:descolar_front/features/post/business/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required int postId,
    required String userId,
    required String username,
    required String content,
    required String postDate,
  }) : super(
          postId: postId,
          userId: userId,
          username: username,
          content: content,
          postDate: postDate,
        );

  factory PostModel.fromJson({required Map<String, dynamic> json}) {
    Map<String, dynamic> user = json['user'];
    Map<String, dynamic> date = json['date'];
    return PostModel(
      postId: json['id'],
      userId: user['uuid'],
      username: user['username'],
      content: json['content'],
      postDate: date['date'],
    );
  }
}
