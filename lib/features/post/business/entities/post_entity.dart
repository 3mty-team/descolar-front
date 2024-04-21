class PostEntity {
  final int postId;
  final String userId;
  final String content;
  final String username;
  final String postDate;
  final int likes;
  final int comments;

  const PostEntity({
    required this.postId,
    required this.userId,
    required this.content,
    required this.username,
    required this.postDate,
    required this.likes,
    required this.comments,
  });
}
