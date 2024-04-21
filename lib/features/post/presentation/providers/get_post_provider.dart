import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/usecases/get_all_post_in_range.dart';
import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';
import 'package:descolar_front/features/post/data/repositories/post_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/failure.dart';

class GetPostProvider extends ChangeNotifier {
  void addPostsToFeed(BuildContext context) async {
    PostRepositoryImpl repository = PostRepositoryImpl(
      remoteDataSource: PostRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrPost =
        await GetAllPostInRange(postRepository: repository).call(
      range: 10,
    );

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
