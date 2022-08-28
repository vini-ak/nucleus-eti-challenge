class ServiceException implements Exception {
  String cause;
  ServiceException(this.cause);
}
