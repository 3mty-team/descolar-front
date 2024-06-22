import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';

class EditProfil {
  final UserProfilRepository userProfilRepository;

  EditProfil({required this.userProfilRepository});

  Future<Either<Failure, bool>> call({
    required int formationId,
    required String biography,
  }) async {
    return await userProfilRepository.editProfil(formationId: formationId, biography: biography);
  }
}
