import 'package:descolar_front/core/constants/constants.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';
import '../models/template_model.dart';

abstract class TemplateRemoteDataSource {
  Future<TemplateModel> getTemplate({required TemplateParams templateParams});
}

class TemplateRemoteDataSourceImpl implements TemplateRemoteDataSource {
  final Dio dio;

  TemplateRemoteDataSourceImpl({required this.dio});

  @override
  Future<TemplateModel> getTemplate({
    required TemplateParams templateParams,
  }) async {
    final response = await dio.get(
      '${baseDescolarApi}/',
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response.statusCode == 200) {
      return TemplateModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
