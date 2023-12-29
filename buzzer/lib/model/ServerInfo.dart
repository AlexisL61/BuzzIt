class ServerInfo {
  final String url;
  final String wsUrl;

  ServerInfo(this.url, this.wsUrl);

  static ServerInfo fromJson(Map<String, dynamic> json) {
    return ServerInfo(json['url'], json['wsUrl']);
  }
}
