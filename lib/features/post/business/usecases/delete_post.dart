import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

class DeletePost {
  final PostRepository postRepository;

  DeletePost({required this.postRepository});

  Future<Either<Failure, bool>> call({
    required PostModel post,
  }) async {
    return await postRepository.deletePost(post: post);
  }
}
