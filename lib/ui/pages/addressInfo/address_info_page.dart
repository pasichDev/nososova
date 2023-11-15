import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
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
                          child: const Center(
                            child: Text(
                              "Empty History",
                              style: TextStyle(
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
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF070F46),
                      Color(0xFF0C1034),
                      Color(0xFF070E4B),
                      Color(0xFF621359),
                      Color(0xFF560D4E),
                    ],
                  ),
                  color: CustomColors.primaryNoso,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color:   Color(0xFF1C203F), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(6, 6), // Shadow position, you can adjust X and Y
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
                              style: AppTextStyles.titleMax.copyWith(fontSize: 36, color: CustomColors.primaryNoso),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              address.hash,
                              style: AppTextStyles.titleMax.copyWith(
                                  fontSize: 24,
                                  color: Colors.white.withOpacity(0.9)),
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
