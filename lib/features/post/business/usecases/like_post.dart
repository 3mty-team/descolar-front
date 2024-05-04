import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class LikePost {
  final PostRepository postRepository;

  LikePost({required this.postRepository});

  Future<Either<Failure, PostEntity>> call({
    required PostEntity post,
  }) async {
    return await postRepository.likePost(post: post);
  }
}
