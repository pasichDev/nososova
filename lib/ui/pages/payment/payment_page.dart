import 'package:flutter/material.dart';
import 'package:nososova/ui/pages/payment/screen/screen_payment.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/address_wallet.dart';
import '../../theme/style/text_style.dart';

class PaymentPage extends StatefulWidget {
  final Address address;
  final String receiver;

  const PaymentPage({Key? key, required this.address, this.receiver = ""})
      : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:  AppBar(title:  Text(
          AppLocalizations.of(context)!.createPayment,
          textAlign: TextAlign.start,
          style: AppTextStyles.dialogTitle.copyWith(fontSize: 22),
        ),),
        body:  PaymentScreen(address: widget.address, receiver: widget.receiver));
  }
}
