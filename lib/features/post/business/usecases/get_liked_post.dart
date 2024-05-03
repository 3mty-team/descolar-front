import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class GetLikedPost {
  final PostRepository postRepository;

  GetLikedPost({required this.postRepository});

  Future<Either<Failure, List<PostEntity>>> call({
    required String userUUID,
  }) async {
    return await postRepository.getLikedPost(userUUID: userUUID);
  }
}
