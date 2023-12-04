import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:nososova/ui/pages/addressInfo/screens/history_transaction.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/utils/const/const.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

import '../../theme/decoration/card_gradient_decoration.dart';
import '../../theme/decoration/other_gradient_decoration.dart';

class AddressInfoPage extends StatelessWidget {
  final Address address;
  final List<Widget> pages = [];

  AddressInfoPage({Key? key, required this.address}) : super(key: key) {
   pages.add(HistoryTransactionsWidget(address: address));
   pages.add(Container());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body:  Container(
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
                  child: FlutterCarousel(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.6,
                      showIndicator: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      slideIndicator: CircularWaveSlideIndicator(),
                    ),
                    items: pages,
                  )),
            ),
            Positioned(
              top: 130,
              left: 20,
              right: 20,
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
                              address.balance.toString(),
                              style: AppTextStyles.titleMax.copyWith(
                                  fontSize: 36,
                                  color: Colors.white.withOpacity(1)),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              address.nameAddressFull,
                              style: AppTextStyles.titleMax.copyWith(
                                  fontSize: 24,
                                  color: Colors.white.withOpacity(0.5)),
                            ),

                            //const SizedBox(height: 10),
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//f4bf24
