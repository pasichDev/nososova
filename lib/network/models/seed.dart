class Seed {
  String ip;
  int ping;
  bool online;

  Seed({
    required this.ip,
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