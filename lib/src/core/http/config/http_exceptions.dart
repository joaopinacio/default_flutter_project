class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}

class HttpException implements Exception {
  final int statusCode;
  final String message;
  HttpException({required this.statusCode, required this.message});
}

class CancelledException implements Exception {
  final String message;
  CancelledException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
