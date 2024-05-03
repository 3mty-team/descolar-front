import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/post/business/usecases/get_liked_post.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/usecases/get_all_post_in_range.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class GetPostProvider extends ChangeNotifier {
  Future<void> addPostsToFeed() async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await GetAllPostInRange(postRepository: repository).call(range: 20);
    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (List<PostEntity> posts) {
        notifyListeners();
      },
    );
  }

  Future<void> getLikedPost() async {
    PostRepository repository = await PostRepository.getPostRepository();
    final failureOrPost = await GetLikedPost(postRepository: repository).call(userUUID: UserInfo.user.uuid);
    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (List<PostEntity> posts) {
        notifyListeners();
      },
    );
  }
}
