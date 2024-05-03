import 'package:descolar_front/features/post/data/models/post_model.dart';

class CommentEntity {
  final int commentID;
  final String userID;
  final PostModel post;
  final String content;
  final String username;
  final DateTime commentDate;

  const CommentEntity({
    required this.commentID,
    required this.userID,
    required this.post,
    required this.content,
    required this.username,
    required this.commentDate,
  });
}
