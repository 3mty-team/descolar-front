import 'package:dartz/dartz.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';

abstract class PostRepository {
  Future<Either<Failure, PostEntity>> getPostByID({
    required int postID,
  });

  Future<Either<Failure, PostEntity>> createPost({
    required CreatePostParams params,
  });

  Future<Either<Failure, PostEntity>> repostPost({
    required int postID,
  });

  Future<Either<Failure, PostEntity>> deletePost({
    required int postID,
  });

  Future<Either<Failure, List<PostEntity>>> getAllPostInRange({
    required int range,
  });

  Future<Either<Failure, List<PostEntity>>> getAllPostInRangeWithTimestamp({
    required int range,
    required DateTime timestamp,
  });

  Future<Either<Failure, List<PostEntity>>> getAllPostInRangeWithUserUUID({
    required int range,
    required String userUUID,
  });
}
