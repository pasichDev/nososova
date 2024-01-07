import 'package:noso_dart/const.dart';
import 'package:noso_dart/models/address_object.dart';
import 'package:noso_dart/models/app_info.dart';
import 'package:noso_dart/noso.dart';

class NewOrderSend {
  String? orderID;
  int? orderLines;
  String? orderType;
  int? timeStamp;
  String? reference;
  int? trxLine;
  String? sender;
  String? address;
  String? receiver;
  int? amountFee;
  int? amountTrf;
  String? signature;
  String trfrID;

  NewOrderSend({
    this.orderID,
    this.orderLines,
    this.orderType,
    this.timeStamp,
    this.reference = "null",
    this.trxLine,
    this.sender,
    this.address,
    this.receiver,
    this.amountFee,
    this.amountTrf,
    this.signature,
    this.trfrID = "",
  });

  /// Returns the model data as a prepared string
  String _getStringToData() {
    return "$orderType $orderID ${orderLines.toString()} $orderType ${timeStamp.toString()} $reference ${trxLine.toString()} $sender $address $receiver ${amountFee.toString()} ${amountTrf.toString()} $signature $trfrID";
  }

  /// This string returns a prepared string for sending the payment
  getOrderString(AddressObject targetAddress, String message, String receiver,
      int amount, int commission, int block, int countTrx, AppInfo appInfo) {
    final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const int trxLine = 1;
    const String type = "ORDER";

    var messageSignature = (currentTimeMillis.toString() +
        targetAddress.hash +
        receiver +
        amount.toString() +
        commission.toString() +
        trxLine.toString());
    var signature =
        Noso().signMessage(messageSignature, targetAddress.privateKey);

    NewOrderSend orderInfo = NewOrderSend(
        orderID: '',
        orderLines: trxLine,
        orderType: "TRFR",
        timeStamp: currentTimeMillis,
        reference: message,
        trxLine: trxLine,
        sender: targetAddress.publicKey,
        address: targetAddress.hash,
        receiver: receiver,
        amountFee: commission,
        amountTrf: amount,
        signature: Noso().encodeSignatureToBase64(signature),
        trfrID: Noso().getTransferHash(currentTimeMillis.toString() +
            targetAddress.hash +
            receiver +
            amount.toString() +
            block.toString()));

    orderInfo.orderID = Noso().getOrderHash(
        "$trxLine${currentTimeMillis.toString() + orderInfo.trfrID}");

    var orderStringCustom =
        "NSL$type ${appInfo.protocol} ${appInfo.appVersion} ${DateTime.now().millisecondsSinceEpoch ~/ 1000} ORDER $trxLine \$${orderInfo._getStringToData()} \$";

    return orderStringCustom.substring(0, orderStringCustom.length - 2);
  }

  /// Returns the query string to change the alias
  getAliasOrderString(
      AddressObject targetAddress, String alias, AppInfo appInfo) {
    final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const int trxLine = 1;
    const String type = "CUSTOM";

    var signature = Noso().signMessage(
        'Customize this ${targetAddress.nameAddressFull} $alias',
        targetAddress.privateKey);

    NewOrderSend orderInfo = NewOrderSend(
        orderID: '',
        orderLines: trxLine,
        orderType: type,
        timeStamp: currentTimeMillis,
        reference: 'null',
        trxLine: trxLine,
        sender: targetAddress.publicKey,
        address: targetAddress.nameAddressFull,
        receiver: alias,
        amountFee: NosoConst.customizationFee,
        amountTrf: 0,
        signature: Noso().encodeSignatureToBase64(signature),
        trfrID: Noso().getTransferHash(currentTimeMillis.toString() +
            targetAddress.nameAddressFull +
            alias));

    orderInfo.orderID = Noso().getOrderHash(
        "$trxLine${currentTimeMillis.toString() + orderInfo.trfrID}");

    var orderStringCustom =
        "NSL$type ${appInfo.protocol} ${appInfo.appVersion} ${DateTime.now().millisecondsSinceEpoch ~/ 1000} ORDER $trxLine \$${orderInfo._getStringToData()} \$";

    return orderStringCustom.substring(0, orderStringCustom.length - 2);
  }
}
