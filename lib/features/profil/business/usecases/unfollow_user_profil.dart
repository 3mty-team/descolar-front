import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';

class UnfollowUserProfil {
  final UserProfilRepository userProfilRepository;

  UnfollowUserProfil({required this.userProfilRepository});

  Future<Either<Failure, UserProfilEntity>> call({
    required String uuid,
  }) async {
    return await userProfilRepository.unfollow(uuid: uuid);
  }
}
