import '../../const/const.dart';
import '../nosocore.dart';
import '../src/crypto.dart';
import 'address_object.dart';

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
    this.reference,
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
  getOrderString(Address targetAddress, String message, String receiver, int amount, int commission, int block, int countTrx) {
    final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const int trxLine = 1;
    const String type = "ORDER";

    var messageSignature = (currentTimeMillis.toString() +
        targetAddress.hash +
        receiver +
        amount.toString() +
        commission.toString() +
        countTrx.toString());
    var signature = NosoCrypto().signMessage(messageSignature, targetAddress.privateKey);

    NewOrderSend orderInfo = NewOrderSend(
        orderID: '',
        orderLines: countTrx,
        orderType: "TRFR",
        timeStamp: currentTimeMillis,
        reference: message,
        trxLine: countTrx,
        sender: targetAddress.publicKey,
        address: targetAddress.hash,
        receiver: receiver,
        amountFee: commission,
        amountTrf: amount,
        signature: NosoCrypto().encodeSignatureToBase64(signature),
        trfrID: NosoCore().getTransferHash(currentTimeMillis.toString() +
            targetAddress.hash +
            receiver +
            amount.toString() +
            block.toString()));

    orderInfo.orderID = NosoCore().getOrderHash(
        "$trxLine${currentTimeMillis.toString() + orderInfo.trfrID}");

    var orderStringCustom =
        "NSL$type ${Const.protocol} ${Const.programVersion} ${DateTime.now().millisecondsSinceEpoch ~/ 1000} ORDER $trxLine \$${orderInfo._getStringToData()} \$";

    return orderStringCustom.substring(0, orderStringCustom.length - 2);
  }

  /// Returns the query string to change the alias
  getAliasOrderString(Address targetAddress, String alias) {
    final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const int trxLine = 1;
    const String type = "CUSTOM";

    var signature = NosoCrypto().signMessage(
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
        amountFee: Const.customizationFee,
        amountTrf: 0,
        signature: NosoCrypto().encodeSignatureToBase64(signature),
        trfrID: NosoCore().getTransferHash(currentTimeMillis.toString() +
            targetAddress.nameAddressFull +
            alias));

    orderInfo.orderID = NosoCore().getOrderHash(
        "$trxLine${currentTimeMillis.toString() + orderInfo.trfrID}");

    var orderStringCustom =
        "NSL$type ${Const.protocol} ${Const.programVersion} ${DateTime.now().millisecondsSinceEpoch ~/ 1000} ORDER $trxLine \$${orderInfo._getStringToData()} \$";

    return orderStringCustom.substring(0, orderStringCustom.length - 2);
  }
}
