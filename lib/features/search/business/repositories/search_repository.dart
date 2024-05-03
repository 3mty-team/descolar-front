import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';
import 'package:descolar_front/features/search/data/datasources/search_local_data_source.dart';
import 'package:descolar_front/features/search/data/datasources/search_remote_data_source.dart';
import 'package:descolar_front/features/search/data/repositories/search_repository_impl.dart';
import 'package:descolar_front/core/connection/network_info.dart';

abstract class SearchRepository {
  static Future<SearchRepository> getSearchRepository() async {
    return SearchRepositoryImpl(
      remoteDataSource: SearchRemoteDataSourceImpl(dio: Dio()),
      localDataSource: SearchLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
  }

  Future<Either<Failure, List<PostEntity>>> getPostsByContent({
    required String content,
  });

  Future<Either<Failure, List<UserResultEntity>>> getUsersByUsername({
    required String username,
  });
}
