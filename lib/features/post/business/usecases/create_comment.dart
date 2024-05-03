import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/business/repositories/comment_repository.dart';

class CreateComment {
  final CommentRepository commentRepository;

  CreateComment({required this.commentRepository});

  Future<Either<Failure, CommentEntity>> call({
    required CreateCommentParams params,
  }) async {
    return await commentRepository.createComment(params: params);
  }
}
