class ConnectionToken {
  String token;
  String roomId;
  DateTime timeout;

  ConnectionToken(this.token, this.roomId, this.timeout);

  bool isValid(String token, String roomId) {
    return this.token == token && this.roomId == roomId && timeout.isAfter(DateTime.now());
  }
}
