abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class AlreadyExistsFailure extends Failure {
  AlreadyExistsFailure({required super.errorMessage});
}

class NotExistsFailure extends Failure {
  NotExistsFailure({required super.errorMessage});
}

class BlockedFailure extends Failure {
  BlockedFailure({required super.errorMessage});
}
