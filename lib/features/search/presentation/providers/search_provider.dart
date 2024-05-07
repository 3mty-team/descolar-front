import 'package:flutter/material.dart';

import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';
import 'package:descolar_front/features/search/business/repositories/search_repository.dart';
import 'package:descolar_front/features/search/business/usecases/get_posts_by_content.dart';
import 'package:descolar_front/features/search/business/usecases/get_users_by_username.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';

class SearchProvider extends ChangeNotifier {
  Future<List<PostEntity>> getPostsByContent(String content) async {
    SearchRepository repository = await SearchRepository.getSearchRepository();
    List<PostEntity> result = [];
    final failureOrPost = await GetPostsByContent(searchRepository: repository).call(content: content);
    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (List<PostEntity> posts) {
        notifyListeners();
        result = posts;
      },
    );
    return result;
  }

  Future<List<UserResultEntity>> getUsersByUsername(String username) async {
    SearchRepository repository = await SearchRepository.getSearchRepository();
    List<UserResultEntity> result = [];
    final failureOrPost = await GetUsersByUsername(searchRepository: repository).call(username: username);
    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (List<UserResultEntity> users) {
        notifyListeners();
        result = users;
      },
    );
    return result;
  }
}
