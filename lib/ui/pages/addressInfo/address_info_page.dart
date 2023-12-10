import 'package:flutter/material.dart';
import 'package:nososova/ui/pages/addressInfo/screens/history_transaction.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/utils/const/const.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

import '../../theme/decoration/card_gradient_decoration.dart';
import '../../theme/decoration/other_gradient_decoration.dart';

class AddressInfoPage extends StatelessWidget {
  final Address address;

  AddressInfoPage({Key? key, required this.address}) : super(key: key) {}

  ///Відоражати надходження
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        decoration: const OtherGradientDecoration(),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: HistoryTransactionsWidget(address: address)),
            ),
            Positioned(
                top: 130,
                left: 20,
                right: 20,
                child: CardAddress(
                  address: address,
                ))
          ],
        ),
      ),
    );
  }
}

class CardAddress extends StatefulWidget {
  final Address address;

  const CardAddress({super.key, required this.address});

  @override
  CardAddressState createState() => CardAddressState();
}

class CardAddressState extends State<CardAddress> {
  bool flipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          flipped = !flipped;
        });
      },
      child: Transform.scale(
        scale: flipped ? -1 : 1,
        child: Container(
          height: 230,
          decoration: const CardDecoration(),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  Const.coinName,
                  style: AppTextStyles.titleMax
                      .copyWith(color: Colors.white.withOpacity(0.4)),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.address.balance.toString(),
                      style: AppTextStyles.titleMax.copyWith(
                        fontSize: 36,
                        color: Colors.white.withOpacity(1),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.address.nameAddressFull,
                      style: AppTextStyles.titleMax.copyWith(
                        fontSize: 24,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//f4bf24
