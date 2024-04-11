import 'package:image_picker/image_picker.dart';

class PostEntity {
  final int postId;
  final String userId;
  final String content;
  final String location;
  final DateTime postDate;
  final bool isPinned;
  final PostEntity? repostedPost;
  final List<XFile>? medias;

  const PostEntity({
    required this.postId,
    required this.userId,
    required this.content,
    required this.location,
    required this.postDate,
    required this.isPinned,
    this.repostedPost,
    this.medias,
  });
}
