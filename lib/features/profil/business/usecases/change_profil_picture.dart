import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfilPicture {
  final UserProfilRepository userProfilRepository;

  ChangeProfilPicture({required this.userProfilRepository});

  Future<Either<Failure, UserProfilEntity>> call({
    required String uuid,
    required File image,
  }) async {
    return await userProfilRepository.changeProfilPicture(uuid: uuid, image: image);
  }
}
