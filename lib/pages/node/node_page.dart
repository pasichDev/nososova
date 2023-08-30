import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/components/decoration/other_gradient_decoration.dart';

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
    );
  }
}
