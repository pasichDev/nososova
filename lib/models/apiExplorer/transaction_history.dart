class TransactionHistory {
  int blockId;
  String id;
  String timestamp;
  String sender;
  String amount;
  String fee;
  String type;
  String receiver;

  TransactionHistory({
    required this.blockId,
    required this.id,
    required this.timestamp,
    required this.sender,
    required this.amount,
    required this.fee,
    required this.type,
    required this.receiver,
  });

  get obfuscationOrderId => orderIdObfuscation();

  String orderIdObfuscation() {
    if (id.length >= 25) {
      return "${id.substring(0, 9)}...${id.substring(id.length - 9)}";
    }
    return id;
  }

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
      blockId: json['block_id'],
      id: json['order_id'],
      timestamp: json['timestamp'],
      sender: json['sender'],
      amount: json['amount'],
      fee: json['fee'],
      type: json['order_type'],
      receiver: json['receiver'],
    );
  }
}
