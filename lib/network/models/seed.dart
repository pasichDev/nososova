class Seed {
  String ip;
  int ping;
  bool online;

  Seed({
    this.ip = "127.0.0.1",
    this.ping = 0,
    this.online = false,
  });

  Seed copyWith({
    String? ip,
    int? ping,
    bool? online,
  }) {
    return Seed(
      ip: ip ?? this.ip,
      ping: ping ?? this.ping,
      online: online ?? this.online,
    );
  }
}