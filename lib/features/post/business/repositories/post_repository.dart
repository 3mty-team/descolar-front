import 'package:dartz/dartz.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

abstract class TemplateRepository {
  Future<Either<Failure, PostEntity>> createPost({
    required TemplateParams templateParams,
  });
}
