import 'package:drift/drift.dart';

@DataClassName('Address')
class Address {
  String hash;
  String? custom;
  String publicKey;
  String privateKey;
  double  balance;
  double pending;
  int score;
  int lastOP;
  bool isLocked;
  double incoming;
  double outgoing;
  bool nodeAvailable;
  bool nodeStatusOn;

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
    this.nodeAvailable = false,
    this.nodeStatusOn = false,
  });

  Address copyWith({
    required String hash,
    String? custom,
    required String publicKey,
    required String privateKey,
    double? balance,
    double? pending,
    int? score,
    int? lastOP,
    bool? isLocked,
    double? incoming,
    double? outgoing,
    bool? nodeOn,
    bool? nodeStatusOn,
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
      nodeAvailable: nodeAvailable ?? this.nodeAvailable,
      nodeStatusOn: nodeStatusOn ?? this.nodeStatusOn,
    );
  }

  Map<String, dynamic> toJsonExport() {
    return {
      'publicKey': publicKey,
      'privateKey': privateKey,
    };
  }
}
