class Seed {
  String ip;
  int port;
  int ping;
  bool online;
  String? nosoAddress;
  int? count;

  Seed({
    this.ip = "127.0.0.1",
    this.port = 8080,
    this.ping = 0,
    this.online = false,
    this.nosoAddress, this.count
  });

  Seed tokenizer(String string){
    if(string.length <= 5) {
      return this;
    }
    List<String> seedPart = string.split(":");
    ip = seedPart[0];
    port = int.parse(seedPart[1]);
    return this;
  }

  String toTokenizer(){
    return "$ip:$port";
  }

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