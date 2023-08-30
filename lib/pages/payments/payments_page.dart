import 'package:flutter/material.dart';
import 'package:nososova/pages/components/decoration/other_gradient_decoration.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: TwoPartRoundedPage(),
    );
  }
}

class TwoPartRoundedPage extends StatelessWidget {
  const TwoPartRoundedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const OtherGradientDecoration(),
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
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.white,
                child: const Text(
                  'History',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
