import 'package:descolar_front/core/utils/date_converter.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:image_picker/image_picker.dart';

class PostModel extends PostEntity {
  const PostModel({
    required int postId,
    required String userId,
    required String content,
    required String location,
    required DateTime postDate,
    required bool isPinned,
    PostEntity? repostedPost,
    List<XFile>? medias,
  }) : super(
          postId: postId,
          userId: userId,
          content: content,
          location: location,
          postDate: postDate,
          isPinned: isPinned,
          repostedPost: repostedPost,
          medias: medias,
        );

  factory PostModel.fromJson({required Map<String, dynamic> json}) {
    return PostModel(
      postId: json['id'],
      userId: json['user'],
      content: json['content'],
      postDate: formattedStringToDatetime('MM-dd-yyyy', json['date']),
      medias: json['medias'],
      location: '',
      isPinned: false,
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
