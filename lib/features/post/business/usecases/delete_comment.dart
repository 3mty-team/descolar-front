import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/business/repositories/comment_repository.dart';

class DeleteComment {
  final CommentRepository commentRepository;

  DeleteComment({required this.commentRepository});

  Future<Either<Failure, bool>> call({
    required CommentEntity comment,
  }) async {
    return await commentRepository.deleteComment(comment: comment);
  }
}
