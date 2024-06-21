import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';

class GetFormationsByDiploma {
  final UserProfilRepository userProfilRepository;

  GetFormationsByDiploma({required this.userProfilRepository});

  Future<Either<Failure, List<String>>> call({
    required int diplomaId,
  }) async {
    return await userProfilRepository.getFormationsByDiploma(diplomaId: diplomaId);
  }
}
