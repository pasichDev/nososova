import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';

import '../../theme/decoration/other_gradient_decoration.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: null, body: Container(
      decoration:  OtherGradientDecoration(),
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
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.white,
                child:  Center(
                  child: Text(
                    AppLocalizations.of(context)!.notImplemented,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
