import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class RepostPost {
  final PostRepository postRepository;

  RepostPost({required this.postRepository});

  Future<Either<Failure, PostEntity>> call({
    required int postID,
  }) async {
    return await postRepository.repostPost(postID: postID);
  }
}
