import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../theme/decoration/other_gradient_decoration.dart';



class NodePage extends StatelessWidget {
  const NodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: null, body: NodeBody());
  }
}

class NodeBody extends StatelessWidget {
  const NodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const OtherGradientDecoration(),
      child: Stack(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                            ],
                          ),
                        )))
              ]),
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
                 "Nodes",
                  style: AppTextStyles.categoryStyle
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
