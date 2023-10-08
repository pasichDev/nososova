import 'package:drift/drift.dart';

@DataClassName('Address')
class Address {
  String hash;
  String? custom;
  String publicKey;
  String privateKey;
  int balance;
  int pending;
  int score;
  int lastOP;
  bool isLocked;
  int incoming;
  int outgoing;

  Address({
    required this.hash,
    this.custom,
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

  Address copyWith({
    required String hash,
    String? custom,
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
    return Address(
      hash: hash,
      custom: custom ?? this.custom,
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
