import 'package:descolar_front/features/post/business/entities/post_entity.dart';

class CommentEntity {
  final int commentID;
  final String userID;
  final PostEntity post;
  final String content;
  final String username;
  final DateTime commentDate;
  final String? authorPfp;

  const CommentEntity({
    required this.commentID,
    required this.userID,
    required this.post,
    required this.content,
    required this.username,
    required this.commentDate,
    this.authorPfp,
  });
}
