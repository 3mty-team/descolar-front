import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:descolar_front/features/post/data/datasources/post_remote_data_source.dart';

abstract class CommentLocalDateSource {}

class CommentLocalDateSourceImpl implements CommentLocalDateSource {
  final SharedPreferences sharedPreferences;
  final PostRemoteDataSourceImpl remote = PostRemoteDataSourceImpl(dio: Dio());

  CommentLocalDateSourceImpl({required this.sharedPreferences});
}
