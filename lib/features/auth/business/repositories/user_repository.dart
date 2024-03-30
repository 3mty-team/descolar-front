import 'package:dartz/dartz.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser({
    required UserParams templateParams,
  });
}
