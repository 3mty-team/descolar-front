import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/template/business/repositories/template_repository.dart';
import 'package:descolar_front/features/template/data/datasources/template_local_data_source.dart';
import 'package:descolar_front/features/template/data/datasources/template_remote_data_source.dart';
import 'package:descolar_front/features/template/data/models/template_model.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  final TemplateRemoteDataSource remoteDataSource;
  final TemplateLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TemplateRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TemplateModel>> getTemplate({
    required TemplateParams templateParams,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        TemplateModel remoteTemplate =
            await remoteDataSource.getTemplate(templateParams: templateParams);

        localDataSource.cacheTemplate(templateToCache: remoteTemplate);

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        TemplateModel localTemplate = await localDataSource.getLastTemplate();
        return Right(localTemplate);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
