class WalletExp {
  String publicKey;
  String privateKey;

  WalletExp({required this.publicKey, required this.privateKey});

  factory WalletExp.fromJson(Map<String, dynamic> json) {
    return WalletExp(
      publicKey: json['publicKey'],
      privateKey: json['privateKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'publicKey': publicKey,
      'privateKey': privateKey,
    };
  }
}