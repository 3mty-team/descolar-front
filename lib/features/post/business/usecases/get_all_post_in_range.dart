import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class GetAllPostInRange {
  final PostRepository postRepository;

  GetAllPostInRange({required this.postRepository});

  Future<Either<Failure, List<PostEntity>>> call({
    required int range,
  }) async {
    return await postRepository.getAllPostInRange(range: range);
  }
}
