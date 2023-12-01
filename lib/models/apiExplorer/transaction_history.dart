class TransactionHistory {
  int blockId;
  String orderId;
  String timestamp;
  String sender;
  String transferId;
  double orderAmount;
  double orderFee;
  String orderSignature;
  String receiver;

  TransactionHistory({
    required this.blockId,
    required this.orderId,
    required this.timestamp,
    required this.sender,
    required this.transferId,
    required this.orderAmount,
    required this.orderFee,
    required this.orderSignature,
    required this.receiver,
  });

  get obfuscationOrderId => orderIdObfuscation();

  String orderIdObfuscation() {
    if (orderId.length >= 25) {
      return "${orderId.substring(0, 9)}...${orderId.substring(orderId.length - 9)}";
    }
    return orderId;
  }

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
      blockId: json['block_id'],
      orderId: json['order_id'],
      timestamp: json['timestamp'],
      sender: json['sender'],
      transferId: json['transfer_id'],
      orderAmount: json['order_amount'].toDouble(),
      orderFee: json['order_fee'].toDouble(),
      orderSignature: json['order_signature'],
      receiver: json['receiver'],
    );
  }
}
