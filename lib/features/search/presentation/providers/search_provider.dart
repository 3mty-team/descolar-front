import 'package:flutter/material.dart';

import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';
import 'package:descolar_front/features/search/business/repositories/search_repository.dart';
import 'package:descolar_front/features/search/business/usecases/get_posts_by_content.dart';
import 'package:descolar_front/features/search/business/usecases/get_users_by_username.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';

class SearchProvider extends ChangeNotifier {
  List<UserResultEntity>? users;
  List<PostEntity>? posts;

  void init() {
    users = [];
    posts = [];
    notifyListeners();
  }

  void getPostsByContent(String content) async {
    this.posts = null;
    notifyListeners();
    SearchRepository repository = await SearchRepository.getSearchRepository();
    final failureOrPost = await GetPostsByContent(searchRepository: repository).call(content: content);
    failureOrPost.fold(
      (Failure failure) {
        this.posts = null;
        notifyListeners();
      },
      (List<PostEntity> posts) {
        this.posts = posts;
        notifyListeners();
      },
    );
  }

  void getUsersByUsername(String username) async {
    this.users = null;
    notifyListeners();
    SearchRepository repository = await SearchRepository.getSearchRepository();
    final failureOrPost = await GetUsersByUsername(searchRepository: repository).call(username: username);
    failureOrPost.fold(
      (Failure failure) {
        this.users = null;
        notifyListeners();
      },
      (List<UserResultEntity> users) {
        this.users = users;
        notifyListeners();
      },
    );
  }
}
