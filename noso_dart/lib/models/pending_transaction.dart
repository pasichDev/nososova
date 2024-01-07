class PendingTransaction {
  String orderId;
  String orderType;
  String sender;
  String receiver;
  double amountTransfer;
  double amountFee;

  PendingTransaction({
    this.orderId = "",
    this.orderType = "",
    this.sender = "",
    this.receiver = "",
    this.amountTransfer = 0,
    this.amountFee = 0,
  });

  PendingTransaction copyWith({
    String? orderId,
    String? orderType,
    String? address,
    String? sender,
    String? receiver,
    double? amountTransfer,
    double? amountFee,
    int? timeStamp,
  }) {
    return PendingTransaction(
      orderId: orderId ?? this.orderId,
      orderType: orderType ?? this.orderType,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      amountTransfer: amountTransfer ?? this.amountTransfer,
      amountFee: amountFee ?? this.amountFee,
    );
  }

  List<PendingTransaction> parsePendings(List<int>? response) {
    if (response == null || response.isEmpty) {
      return [];
    }
    List<String> array = String.fromCharCodes(response).split(" ");
    List<PendingTransaction> pendingList = [];

    try {
      for (String value in array) {
        var pending = value.split(",");
        if (pending.length == 5) {
          pendingList.add(PendingTransaction(
            orderType: pending[0],
            sender: pending[1],
            receiver: pending[2],
            amountTransfer: int.parse(pending[3]) / 100000000,
            amountFee: int.parse(pending[4]) / 100000000,
          ));
        } else if (pending.length == 6) {
          pendingList.add(PendingTransaction(
            orderId: pending[0],
            orderType: pending[1],
            sender: pending[2],
            receiver: pending[3],
            amountTransfer: int.parse(pending[4]) / 100000000,
            amountFee: int.parse(pending[5]) / 100000000,
          ));
        }
      }
      return pendingList;
    } catch (e) {
      return [];
    }
  }
}
