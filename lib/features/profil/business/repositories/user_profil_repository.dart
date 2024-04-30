import 'package:dartz/dartz.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

abstract class UserProfilRepository {
  Future<Either<Failure, UserProfilEntity>> getUserProfil({
    required String uuid,
  });

  Future<Either<Failure, UserProfilEntity>> getMyUserProfil({
    required String uuid,
  });
}
