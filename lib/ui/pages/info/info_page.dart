import 'package:flutter/material.dart';
import 'package:nososova/ui/pages/info/screen/widget_info_coin.dart';

import '../../theme/decoration/other_gradient_decoration.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
            decoration: const OtherGradientDecoration(),
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        color: Colors.white,
                        child: const WidgetInfoCoin()),
                  )),
            )));
  }
}
