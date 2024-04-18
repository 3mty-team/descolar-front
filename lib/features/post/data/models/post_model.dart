import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:image_picker/image_picker.dart';

class PostModel extends PostEntity {
  const PostModel({
    required int postId,
    required String userId,
    required String content,
    required int postDate,
    List<XFile>? medias,
  }) : super(
          postId: postId,
          userId: userId,
          content: content,
          postDate: postDate,
          medias: medias,
        );

  factory PostModel.fromJson({required Map<String, dynamic> json}) {
    return PostModel(
      postId: json['id'],
      userId: json['user'],
      content: json['content'],
      postDate: json['timestamp'],
      medias: json['medias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': postId,
      'user': userId,
      'content': content,
      'date': postDate.toString(),
      'medias': medias,
    };
  }
}
