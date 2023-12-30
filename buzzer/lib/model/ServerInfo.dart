class ServerInfo {
  final String apiUrl;
  final String wsUrl;

  ServerInfo(this.apiUrl, this.wsUrl);

  static ServerInfo fromJson(Map<String, dynamic> json) {
    return ServerInfo(json['apiUrl'], json['wsUrl']);
  }
}
