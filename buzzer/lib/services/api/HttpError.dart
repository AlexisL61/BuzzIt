class HttpError implements Exception {
  final String message;

  HttpError(this.message);
}