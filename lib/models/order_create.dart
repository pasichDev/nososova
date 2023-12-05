
class NewOrderData {
  String orderID;
  int orderLines;
  String orderType;
  int timeStamp;
  String reference;
  int trxLine;
  String sender;
  String address;
  String receiver;
  int amountFee;
  int amountTrf;
  String signature;
  String trfrID;

  NewOrderData({
    required this.orderID,
    required this.orderLines,
    required this.orderType,
    required this.timeStamp,
    required this.reference,
    required this.trxLine,
    required this.sender,
    required this.address,
    required this.receiver,
    required this.amountFee,
    required this.amountTrf,
    required this.signature,
    required this.trfrID,
  });

  String getStringFromOrder() {
    var order = this;
    return "${order.orderType} ${order.orderID} ${order.orderLines.toString()} ${order.orderType} ${order.timeStamp.toString()} ${order.reference} ${order.trxLine.toString()} ${order.sender} ${order.address} ${order.receiver} ${order.amountFee.toString()} ${order.amountTrf.toString()} ${order.signature} ${order.trfrID}";
  }

}
