class TransactionHistory {
  int blockId;
  String orderId;
  String timestamp;
  String sender;
  String orderAmount;
  String orderFee;
  String orderType;
  String receiver;

  TransactionHistory({
    required this.blockId,
    required this.orderId,
    required this.timestamp,
    required this.sender,
    required this.orderAmount,
    required this.orderFee,
    required this.orderType,
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
      orderAmount: json['amount'],
      orderFee: json['fee'],
      orderType: json['order_type'],
      receiver: json['receiver'],
    );
  }
}
