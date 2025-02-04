import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';

class FollowUserProfil {
  final UserProfilRepository userProfilRepository;

  FollowUserProfil({required this.userProfilRepository});

  Future<Either<Failure, bool>> call({
    required String uuid,
  }) async {
    return await userProfilRepository.follow(uuid: uuid);
  }
}
