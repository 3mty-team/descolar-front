class ServerException implements Exception {
  String? message;
  ServerException();
  ServerException.fromName(this.message);
}

class CacheException implements Exception {
  String? message;
  CacheException();
  CacheException.fromName(this.message);
}

class AlreadyExistsException implements Exception {
  String? message;
  AlreadyExistsException();
  AlreadyExistsException.fromName(this.message);
}

class NotExistsException implements Exception {
  String? message;
  NotExistsException();
  NotExistsException.fromName(this.message);
}

class NotValidException implements Exception {
  String? message;
  NotValidException();
  NotValidException.fromName(this.message);
}

class BlockedException implements Exception {
  String? message;
  BlockedException();
  BlockedException.fromName(this.message);
}
