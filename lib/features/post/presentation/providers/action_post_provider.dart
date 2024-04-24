import 'package:dart_ipify/dart_ipify.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/features/post/business/usecases/repost_post.dart';
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
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';

class ActionPostProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();

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

  void repostPost(BuildContext context, int postID) async {
    PostRepositoryImpl repository = PostRepositoryImpl(
      remoteDataSource: PostRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: PostLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance()),
    );

    final failureOrPost = await RepostPost(postRepository: repository).call(
      params: CreatePostParams(
        content: controller.text,
        location: await Ipify.ipv4(),
        postDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
      postID: postID,
    );

    failureOrPost.fold(
      (Failure failure) {
        notifyListeners();
      },
      (PostEntity post) {
        Navigator.pushReplacementNamed(context, '/home');
        controller.clear();
        notifyListeners();
      },
    );
  }
}
