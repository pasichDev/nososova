class Seed {
  String ip;
  int port;
  int ping;
  bool online;
  String address;
  Seed({
    this.ip = "127.0.0.1",
    this.port = 8080,
    this.ping = 0,
    this.online = false,
    this.address = "",
  });

  Seed tokenizer(String? string){
    if(string == null || string.length <= 5 ) {
      return this;
    }
    List<String> seedPart = string.split(":");
    ip = seedPart[0];
    port = 8080; //int.parse(seedPart[1])
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
    String? address,
  }) {
    return Seed(
      ip: ip ?? this.ip,
      port: port ?? this.port,
      ping: ping ?? this.ping,
      online: online ?? this.online,
      address: address ?? this.address,
    );
  }
}