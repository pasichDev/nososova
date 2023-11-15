import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

class PaymentPage extends StatelessWidget {
  final Address address;

  const PaymentPage({super.key, required this.address});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [
        const SizedBox(height: 20),
        Text("Create payment", style: AppTextStyles.dialogTitle.copyWith(fontSize: 36),),
        const SizedBox(height: 20)
      ],))
    );
  }
}

//f4bf24
