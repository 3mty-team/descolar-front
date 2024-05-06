import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:image_picker/image_picker.dart';

class NoParams {}

class TemplateParams {}

class UserParams {
  final String email;
  final String lastname;
  final String firstname;
  final String dateOfBirth;
  final String username;
  final String password;

  const UserParams({
    required this.email,
    required this.lastname,
    required this.firstname,
    required this.dateOfBirth,
    required this.username,
    required this.password,
  });
}

class UserLoginParams {
  final String username;
  final String password;
  final bool? remember;

  const UserLoginParams({
    required this.username,
    required this.password,
    this.remember = false,
  });
}

class CreatePostParams {
  final String content;
  final String location;
  final int postDate;
  final PostEntity? repostedPost;
  final List<XFile>? media;

  const CreatePostParams({
    required this.content,
    required this.location,
    required this.postDate,
    this.repostedPost,
    this.media,
  });
}

class CreateCommentParams {
  final PostEntity post;
  final String content;
  final int commentDate;

  const CreateCommentParams({
    required this.post,
    required this.content,
    required this.commentDate,
  });
}

class CreateMessageParams {
  final String receiverUuid;
  final String content;
  final DateTime date;
  final List<XFile>? medias;

  const CreateMessageParams({
    required this.receiverUuid,
    required this.content,
    required this.date,
    this.medias,
  });
}

class UserProfilParams {
  final String lastname;
  final String firstname;
  final String username;
  final int followers;
  final int following;

  const UserProfilParams({
    required this.lastname,
    required this.firstname,
    required this.username,
    required this.followers,
    required this.following,
  });
}

class ReportPostParams {
  final PostEntity post;
  final int reportCategoryID;
  final String comment;
  final int date;

  const ReportPostParams({
    required this.post,
    required this.reportCategoryID,
    required this.comment,
    required this.date,
  });
}
