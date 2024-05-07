import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/business/repositories/user_profil_repository.dart';

class ReportUserProfil {
  final UserProfilRepository userProfilRepository;

  ReportUserProfil({required this.userProfilRepository});

  Future<Either<Failure, bool>> call({
    required ReportUserParams params,
  }) async {
    return await userProfilRepository.report(params: params);
  }
}
