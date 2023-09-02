class Seed {
  String ip;
  int port;
  int ping;
  bool online;

  Seed({
    this.ip = "127.0.0.1",
    this.port = 8080,
    this.ping = 0,
    this.online = false,
  });

  Seed copyWith({
    String? ip,
    int? port,
    int? ping,
    bool? online,
  }) {
    return Seed(
      ip: ip ?? this.ip,
      port: port ?? this.port,
      ping: ping ?? this.ping,
      online: online ?? this.online,
    );
  }
}