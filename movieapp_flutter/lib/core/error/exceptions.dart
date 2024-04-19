class ServerException implements Exception {
  final String message;
  const ServerException([this.message = "A problem occurred."]);

  @override
  String toString() {
    return message;
  }
}
