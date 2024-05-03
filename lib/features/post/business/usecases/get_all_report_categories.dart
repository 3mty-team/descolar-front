import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/repositories/post_repository.dart';

class GetAllReportCategories {
  final PostRepository postRepository;

  GetAllReportCategories({required this.postRepository});

  Future<Either<Failure, List<String>>> call() async {
    return await postRepository.getAllReportCategories();
  }
}
