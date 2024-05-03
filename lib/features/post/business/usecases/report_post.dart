import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class ReportPost {
  final PostRepository postRepository;

  ReportPost({required this.postRepository});

  Future<Either<Failure, bool>> call({
    required ReportPostParams params,
  }) async {
    return await postRepository.reportPost(params: params);
  }
}
