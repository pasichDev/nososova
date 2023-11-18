import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../generated/assets.dart';
import '../../../utils/noso/src/address_object.dart';
import '../../theme/style/text_style.dart';




class PaymentPage extends StatefulWidget {
  final Address address;

  const PaymentPage({Key? key, required this.address}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  bool isFinished = false;


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
                borderRadius: BorderRadius.circular(10.0),
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 18,
                fontFamily: "GilroyBold",
              ),
              decoration: InputDecoration(
                filled: true,
                hintText: "Recipient",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: "GilroyBold",
                ),
                fillColor: Colors.transparent,
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
              ],
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 18,
                fontFamily: "GilroyBold",
              ),
              decoration: InputDecoration(
                filled: true,
                hintText: "Payment amount",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: "GilroyBold",
                ),
                fillColor: Colors.transparent,
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 18,
                fontFamily: "GilroyBold",
              ),
              decoration: InputDecoration(
                filled: true,
                hintText: "Reference",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: "GilroyBold",
                ),
                fillColor: Colors.transparent,
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SwipeableButtonView(
              buttonText: 'SLIDE TO PAYMENT',
              buttonWidget: const Icon(Icons.arrow_forward_ios_rounded,
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
                await Navigator.push(context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: Container()));
                setState(() {
                  isFinished = false;
                });
              },
            )]),
          ],
        ),
      ),
    );
  }
}
