import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';

class GetAllDiplomas {
  final UserProfilRepository userProfilRepository;

  GetAllDiplomas({required this.userProfilRepository});

  Future<Either<Failure, List<String>>> call() async {
    return await userProfilRepository.getAllDiplomas();
  }
}
