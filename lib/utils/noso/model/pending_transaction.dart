class PendingTransaction {
  String orderType;
  String sender;
  String receiver;
  double amountTransfer;
  double amountFee;

  PendingTransaction({
     this.orderType = "",
     this.sender = "",
     this.receiver = "",
     this.amountTransfer = 0,
     this.amountFee = 0,
  });

  PendingTransaction copyWith({
    String? orderType,
    String? address,
    String? receiver,
    double? amountTransfer,
    double? amountFee,
    int? timeStamp,
  }) {
    return PendingTransaction(
      orderType: orderType ?? this.orderType,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      amountTransfer: amountTransfer ?? this.amountTransfer,
      amountFee: amountFee ?? this.amountFee,
    );
  }
}
