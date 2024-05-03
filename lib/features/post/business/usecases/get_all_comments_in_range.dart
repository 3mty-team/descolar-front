import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/business/repositories/comment_repository.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

class GetAllCommentsInRange {
  final CommentRepository commentRepository;

  GetAllCommentsInRange({required this.commentRepository});

  Future<Either<Failure, List<CommentEntity>>> call({
    required PostEntity post,
    required int range,
  }) async {
    return await commentRepository.getAllCommentsInRange(post: post, range: range);
  }
}
