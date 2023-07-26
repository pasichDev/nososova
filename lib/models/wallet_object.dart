class WalletObject {
  String? hash;
  String? custom;
  String? publicKey;
  String? privateKey;
  int balance;
  int pending;
  int score;
  int lastOP;
  bool isLocked;
  int incoming;
  int outgoing;

  WalletObject({
    this.hash,
    this.custom,
    this.publicKey,
    this.privateKey,
    this.balance = 0,
    this.pending = 0,
    this.score = 0,
    this.lastOP = 0,
    this.isLocked = false,
    this.incoming = 0,
    this.outgoing = 0,
  });

  WalletObject copyWith({
    String? hash,
    String? custom,
    String? publicKey,
    String? privateKey,
    int? balance,
    int? pending,
    int? score,
    int? lastOP,
    bool? isLocked,
    int? incoming,
    int? outgoing,
  }) {
    return WalletObject(
      hash: hash ?? this.hash,
      custom: custom ?? this.custom,
      publicKey: publicKey ?? this.publicKey,
      privateKey: privateKey ?? this.privateKey,
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
