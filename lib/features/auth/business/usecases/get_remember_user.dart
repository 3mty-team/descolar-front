import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/features/auth/business/repositories/user_repository.dart';

class GetRememberUser {
  final UserRepository userRepository;

  GetRememberUser({required this.userRepository});

  Future<Either<Failure, UserEntity?>> call() async {
    return await userRepository.getRememberUser();
  }
}
