import 'dart:ui';

class PostEntity {
  final int postId;
  final String userId;
  final String content;
  final String username;
  final DateTime postDate;
  final int likes;
  final int comments;
  final PostEntity? repostedPost;
  final List<String>? mediasPath;
  final String? authorPfp;

  const PostEntity({
    required this.postId,
    required this.userId,
    required this.content,
    required this.username,
    required this.postDate,
    required this.likes,
    required this.comments,
    this.repostedPost,
    this.mediasPath,
    this.authorPfp,
  });
}
