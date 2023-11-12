import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

import '../../theme/decoration/other_gradient_decoration.dart';
import '../../theme/style/colors.dart';

class AddressInfoPage extends StatelessWidget {
  final Address address;

  const AddressInfoPage({super.key, required this.address});

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
                child: FlutterCarousel(
                  options: CarouselOptions(

                    height: MediaQuery.of(context).size.height * 0.55,
                    showIndicator: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    slideIndicator: CircularWaveSlideIndicator(),
                  ),
                  items: [1,2].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                           height: MediaQuery.of(context).size.height * 0.6,
                          width: double.infinity,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.notImplemented,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )



              ),
            ),
            Positioned(
              top: 130,
              left: 20,
              right: 20,
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                  color: CustomColors.primaryNoso,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:  const Color(0xff3f270a).withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: const Offset(-0, 8), // Shadow position, you can adjust X and Y
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Text(
                        "NOSO",
                        style: AppTextStyles.titleMax
                            .copyWith(color: CustomColors.secondaryNoso),
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
                              style: AppTextStyles.titleMax.copyWith(fontSize: 36, color: Colors.white.withOpacity(0.8)),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              address.hash,
                              style: AppTextStyles.titleMax.copyWith(
                                  fontSize: 24,
                                  color: CustomColors.secondaryNoso),
                            ),

                            const SizedBox(height: 10),

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
