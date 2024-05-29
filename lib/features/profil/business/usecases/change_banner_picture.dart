import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';

class ChangeBannerPicture {
  final UserProfilRepository userProfilRepository;

  ChangeBannerPicture({required this.userProfilRepository});

  Future<Either<Failure, bool>> call({
    required String uuid,
    required File image,
  }) async {
    return await userProfilRepository.changeProfilBanner(uuid: uuid, image: image);
  }
}
