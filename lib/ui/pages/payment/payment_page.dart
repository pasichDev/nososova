import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/ui/theme/decoration/textfield_decoration.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../generated/assets.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/noso/src/address_object.dart';
import '../../../utils/noso/utils.dart';
import '../../theme/style/text_style.dart';

class PaymentPage extends StatefulWidget {
  final Address address;

  const PaymentPage({Key? key, required this.address}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  bool isFinished = false;

  TextEditingController amountController = TextEditingController();
  double comission = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Create payment",
              textAlign: TextAlign.start,
              style: AppTextStyles.dialogTitle.copyWith(fontSize: 36),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15),
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
                      widget.address.hash,
                      style: AppTextStyles.dialogTitle.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
                style: AppTextStyles.textFieldStyle,
                decoration:
                    AppTextFiledDecoration.defaultDecoration("Recipient")),
            const SizedBox(height: 30),
            TextField(
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttonPercent(25),
                buttonPercent(50),
                buttonPercent(75),
                buttonPercent(100),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
                style: AppTextStyles.textFieldStyle,
                decoration:
                    AppTextFiledDecoration.defaultDecoration("Reference")),
            const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.commission,
              style: AppTextStyles.walletAddress
                  .copyWith(color: Colors.black.withOpacity(1), fontSize: 18),
            ),
            const SizedBox(height: 5),
              Text(
                comission.toStringAsFixed(8),
                style: AppTextStyles.walletAddress
                    .copyWith(color: Colors.black, fontSize: 18),
              ),
             ]),
            const SizedBox(height: 30),

            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SwipeableButtonView(
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

  buttonPercent(int percent) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            double value = calculatePercentage(widget.address.balance, percent);
            amountController.text = value.toString();
            comission = UtilsDataNoso.getFee(value) / 100000000;
          });
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text("$percent%",
                style: const TextStyle(fontSize: 18, color: Colors.black))));
  }
  double calculatePercentage(double amount, int percentage) {
    return (percentage / 100) * amount;
  }

}
