import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';
import 'package:descolar_front/features/search/business/repositories/search_repository.dart';

class GetUsersByUsername {
  final SearchRepository searchRepository;

  GetUsersByUsername({required this.searchRepository});

  Future<Either<Failure, List<UserResultEntity>>> call({
    required String username,
  }) async {
    return await searchRepository.getUsersByUsername(username: username);
  }
}
