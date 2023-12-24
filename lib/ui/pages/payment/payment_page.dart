import 'package:flutter/material.dart';
import 'package:nososova/ui/pages/payment/screen/screen_payment.dart';

import '../../../utils/noso/model/address_object.dart';

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
    return PaymentScreen(address: widget.address, receiver: widget.receiver);
  }
}
