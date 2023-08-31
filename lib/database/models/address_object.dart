class AddressObject {
  String hash;
  String custom;
  String publicKey;
  String privateKey;
  int balance;
  int pending;
  int score;
  int lastOP;
  bool isLocked;
  int incoming;
  int outgoing;

  AddressObject({
    required this.hash,
    this.custom = "",
    required this.publicKey,
    required this.privateKey,
    this.balance = 0,
    this.pending = 0,
    this.score = 0,
    this.lastOP = 0,
    this.isLocked = false,
    this.incoming = 0,
    this.outgoing = 0,
  });

  AddressObject copyWith({
    required String hash,
    String custom = "",
    required String publicKey,
    required String privateKey,
    int? balance,
    int? pending,
    int? score,
    int? lastOP,
    bool? isLocked,
    int? incoming,
    int? outgoing,
  }) {
    return AddressObject(
      hash: hash,
      custom: custom,
      publicKey: publicKey,
      privateKey: privateKey,
      balance: balance ?? this.balance,
      pending: pending ?? this.pending,
      score: score ?? this.score,
      lastOP: lastOP ?? this.lastOP,
      isLocked: isLocked ?? this.isLocked,
      incoming: incoming ?? this.incoming,
      outgoing: outgoing ?? this.outgoing,
    );
  }
}
