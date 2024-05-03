import 'dart:ui';

import 'package:descolar_front/features/post/data/models/post_model.dart';

class PostEntity {
  final int postId;
  final String userId;
  final String content;
  final String username;
  final DateTime postDate;
  final int likes;
  final int comments;
  final PostModel? repostedPost;
  final List<Image>? medias;

  const PostEntity({
    required this.postId,
    required this.userId,
    required this.content,
    required this.username,
    required this.postDate,
    required this.likes,
    required this.comments,
    this.repostedPost,
    this.medias,
  });
}
