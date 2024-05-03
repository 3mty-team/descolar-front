import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class DeletePost {
  final PostRepository postRepository;

  DeletePost({required this.postRepository});

  Future<Either<Failure, bool>> call({
    required PostEntity post,
  }) async {
    return await postRepository.deletePost(post: post);
  }
}
