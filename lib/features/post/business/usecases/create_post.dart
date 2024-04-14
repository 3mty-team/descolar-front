import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class CreatePost {
  final PostRepository postRepository;

  CreatePost({required this.postRepository});

  Future<Either<Failure, PostEntity>> call({
    required CreatePostParams params,
  }) async {
    return await postRepository.createPost(params: params);
  }
}
