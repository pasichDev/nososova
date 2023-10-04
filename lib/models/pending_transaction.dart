class PendingTransaction {
  String orderType;
  String address;
  String receiver;
  String amountTransfer;
  String amountFee;
  // : TRFR,N3KN552Qbp7gjA7tpdnh1L4Wq96pkCg,N3Jr5iRk7ugsWfUzVjotHUoRW7vHjGb,100025000,1000000

  PendingTransaction({
    required this.orderType,
    required this.address,
    required this.receiver,
    required this.amountTransfer,
    required this.amountFee,
  });

  // Метод copyWith для оновлення об'єкта
  PendingTransaction copyWith({
    String? orderType,
    String? address,
    String? receiver,
    String? amountTransfer,
    String? amountFee,
    int? timeStamp,
  }) {
    return PendingTransaction(
      orderType: orderType ?? this.orderType,
      address: address ?? this.address,
      receiver: receiver ?? this.receiver,
      amountTransfer: amountTransfer ?? this.amountTransfer,
      amountFee: amountFee ?? this.amountFee,
    );
  }
}
