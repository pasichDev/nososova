import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/ui/theme/decoration/textfield_decoration.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../blocs/events/wallet_events.dart';
import '../../../blocs/wallet_bloc.dart';
import '../../../generated/assets.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/noso/model/address_object.dart';
import '../../../utils/noso/utils.dart';
import '../../theme/style/colors.dart';
import '../../theme/style/text_style.dart';

class PaymentPage extends StatefulWidget {
  final Address address;
  final String receiver;

  const PaymentPage({Key? key, required this.address, this.receiver = ""}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  bool isFinished = false;
  bool isActiveButtonSend = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  TextEditingController messageControler = TextEditingController();

  double selButton = 0;

  double comission = 0;

  @override
  void initState() {
    receiverController.text = widget.receiver.isEmpty ? "" : widget.receiver;
    super.initState();
  }

  /// TODO DAILY
  /// Додати кнопки вибору адреси



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(title:  Text(
        AppLocalizations.of(context)!.createPayment,
        textAlign: TextAlign.start,
        style: AppTextStyles.dialogTitle.copyWith(fontSize: 22),
      ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.sender,
              textAlign: TextAlign.start,
              style: AppTextStyles.dialogTitle.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),

              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.iconsCard,
                      width: 26,
                      height: 26,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.address.nameAddressFull,
                      style: AppTextStyles.itemStyle.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.receiver,
              textAlign: TextAlign.start,
              style: AppTextStyles.dialogTitle.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 10),
            TextField(
                controller: receiverController,
                style: AppTextStyles.textFieldStyle,
                decoration:
                    AppTextFiledDecoration.defaultDecoration( AppLocalizations.of(context)!.receiver)),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.amount,
              textAlign: TextAlign.start,
              style: AppTextStyles.dialogTitle.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (text) {
                if(mounted && selButton != 0) {
                  setState(() {
                  selButton = 0;
                });
                }
              },
                controller: amountController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                style: AppTextStyles.textFieldStyle,
                decoration:
                    AppTextFiledDecoration.defaultDecoration("0.0000000")),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttonPercent(25),
                buttonPercent(50),
                buttonPercent(75),
                buttonPercent(100),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
                controller: messageControler,
                style: AppTextStyles.textFieldStyle,
                decoration:
                    AppTextFiledDecoration.defaultDecoration(AppLocalizations.of(context)!.message)),
            const SizedBox(height: 20),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.commission,
                    style: AppTextStyles.walletAddress.copyWith(
                        color: Colors.black.withOpacity(1), fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    (comission / 100000000).toStringAsFixed(8),
                    style: AppTextStyles.walletAddress
                        .copyWith(color: Colors.black, fontSize: 18),
                  ),
                ]),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => sendOrder(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Test Order",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black)))),
            ),
            SizedBox(height: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SwipeableButtonView(
                isActive: isActiveButtonSend,
                buttonText: 'SLIDE TO PAYMENT',
                buttonWidget: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
                activeColor: const Color(0xFF2B2F4F),
                isFinished: isFinished,
                onWaitingProcess: () {
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      isFinished = true;
                    });
                  });
                },
                onFinish: () async {
                  await Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Container()));
                  setState(() {
                    isFinished = false;
                  });
                },
              )
            ]),
          ],
        ),
      ),
    );
  }

  int doubleToIndianInt(double value) {
    return (value * 100000000).round();
  }

  //ErrorCode := 6
  /// Додати зміінну в адрес про реальний бланс з урахуванням очікувань та імпортити її вbalanceAdress



  int getAmount(){
    return (double.parse(amountController.text) * 100000000).toInt();
  }
  double _bigEndianToDouble(List<int> bytes) {
    var byteBuffer = Uint8List.fromList(bytes).buffer;
    var dataView = ByteData.view(byteBuffer);
    var intValue = dataView.getInt64(0, Endian.little);
    return intValue / 100000000;
  }

  sendOrder() {
    var block = BlocProvider.of<WalletBloc>(context);
    block.add(SendOrder(receiverController.text,messageControler.text, getAmount(), widget.address));
  }

  /*

    var block = BlocProvider.of<WalletBloc>(context);
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var amount = doubleToIndianInt(double.parse(amountController.text));
  //  var fre = NosoCore().getFee(double.parse(amountController.text)); це вернути
    var fre = 0;
    var trxLine = 1;
    var prbl = " ";

    //  int amountBigIndian = NosoCore().doubleToBigEndian(amount);
    //   print(doubleToIndianInt(amount));
    var sender = widget.address.nameAddressFull;
    var reciver = receiverController.text;

    var ORDERHASHSTRING = currentTimeMillis.toString();

    var message = (currentTimeMillis.toString() +
        widget.address.hash +
        reciver +
        amount.toString() +
        fre.toString() +
        trxLine.toString());

    var signature =
        NosoCrypto().signMessage(message, widget.address.privateKey);

    NewOrderSend orderInfo = NewOrderSend(
        orderID: '',
        orderLines: trxLine,
        orderType: "TRFR",
        timeStamp: currentTimeMillis,
        reference: '',
        trxLine: trxLine,
        sender: widget.address.publicKey,
        address: sender,
        receiver: reciver,
        amountFee: doubleToIndianInt(comission),
        amountTrf: amount,
        signature: NosoCrypto().encodeSignatureToBase64(signature),
        trfrID: NosoCore().getTransferHash(currentTimeMillis.toString() +
            widget.address.nameAddressFull +
            reciver +
            amount.toString() +
            block.appDataBloc.state.node.lastblock.toString()));

   // ORDERHASHSTRING += orderInfo.trfrID;

    orderInfo.orderID = NosoCore().getOrderHash("$trxLine$ORDERHASHSTRING");
    print("new OrderID ->${orderInfo.orderID}");

    var resultOrderId = NosoCore().getOrderHash("$trxLine$ORDERHASHSTRING");
    print("ResultOrderID ->${resultOrderId}");

    var protocol = "1";
    var prgramVersion = "NOSOSOVA";// "1.0";
    var ORDERSTRINGSEND = "NSLORDER" +
        prbl +
        protocol +
        prbl +
        prgramVersion +
        prbl +
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString() +
        prbl +
        "ORDER" +
        prbl +
        trxLine.toString() +
        " \$";

  //  ORDERSTRINGSEND += "${orderInfo.getStringFromOrder()} \$";

    ORDERSTRINGSEND = ORDERSTRINGSEND.substring(0, ORDERSTRINGSEND.length - 2);

    //block.add(SendOrder(ORDERSTRINGSEND));
   */

  checkButtonActive() {
    var priceCheck = widget.address.balance <=
        double.parse(amountController.text) + comission;
    var receiverCheck = receiverController.text.length >= 2;

    setState(() {
      isActiveButtonSend = priceCheck && receiverCheck;
    });
  }

  buttonPercent(int percent) {
    double value = calculatePercentage(widget.address.balance, percent);
    return OutlinedButton(
        onPressed: () {
          setState(() {

            amountController.text = value.toString();
            comission = UtilsDataNoso.getFee(value);
            selButton = value;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: selButton == value ? CustomColors.primaryColor.withOpacity(0.3) : Colors.transparent,
          side:  BorderSide(color: selButton == value ? CustomColors.primaryColor.withOpacity(0.5) : Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text("$percent%",
                style:  TextStyle(fontSize: 16, fontWeight: selButton == value ? FontWeight.bold : FontWeight.normal, color: selButton == value ? CustomColors.primaryColor.withOpacity(0.9) : Colors.black))));
  }

  double calculatePercentage(double amount, int percentage) {
    return (percentage / 100) * amount;
  }
}
