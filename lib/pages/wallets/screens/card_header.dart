import 'package:flutter/material.dart';
import 'package:nososova/const.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/app_state.dart';
import 'package:nososova/pages/components/decoration/standart_gradient_decoration.dart';
import 'package:nososova/pages/wallets/screens/header_info.dart';
import 'package:provider/provider.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, homeViewModel, _) {
      return Container(
        width: double.infinity,
        decoration: const StandartGradientDecoration(),
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CardBody(0)),
        ),
      );
    });
  }
}

class CardBody extends StatelessWidget {
  int totalBalance = 0;

  CardBody(int totalBalance, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.overallOnBalance,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              totalBalance.toString(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              Const.coinName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // const ,
        const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
            child: HeaderInfo()),
      ],
    );
  }
}
