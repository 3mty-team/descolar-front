import 'package:dartz/dartz.dart';

import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/search/business/repositories/search_repository.dart';

class GetPostsByContent {
  final SearchRepository searchRepository;

  GetPostsByContent({required this.searchRepository});

  Future<Either<Failure, List<PostEntity>>> call({
    required String content,
  }) async {
    return await searchRepository.getPostsByContent(content: content);
  }
}
