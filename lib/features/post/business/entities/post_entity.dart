import 'package:image_picker/image_picker.dart';

class PostEntity {
  final int postId;
  final String userId;
  final String content;
  final int postDate;
  final List<XFile>? medias;

  const PostEntity({
    required this.postId,
    required this.userId,
    required this.content,
    required this.postDate,
    this.medias,
  });
}
