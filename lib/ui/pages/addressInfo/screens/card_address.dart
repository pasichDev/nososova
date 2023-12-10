import 'package:flutter/material.dart';

import '../../../../utils/const/const.dart';
import '../../../../utils/noso/src/address_object.dart';
import '../../../theme/decoration/card_gradient_decoration.dart';
import '../../../theme/style/text_style.dart';

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
