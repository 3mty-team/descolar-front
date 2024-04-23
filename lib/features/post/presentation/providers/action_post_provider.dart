import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/features/post/business/usecases/delete_post.dart';
import 'package:descolar_front/features/post/data/datasources/post_local_data_source.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/features/post/data/repositories/post_repository_impl.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';

class ActionPostProvider extends ChangeNotifier {
  void deletePost(BuildContext context, PostModel post) async {
    PostRepositoryImpl repository = PostRepositoryImpl(
      remoteDataSource: PostRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance()),
    );

    final failureOrPost = await DeletePost(postRepository: repository).call(post: post);

    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (bool response) {
        notifyListeners();
      },
    );
  }
}
