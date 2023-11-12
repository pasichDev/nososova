import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/utils/const/const.dart';

import '../../../../blocs/wallet_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../theme/decoration/standart_gradient_decoration_round.dart';
import '../../../theme/style/text_style.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const HomeGradientDecorationRound(),
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: CardBody(0)),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  int totalBalance = 0;

  CardBody(int totalBalance, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                state.wallet.balanceTotal.toStringAsFixed(2),
                style: AppTextStyles.titleMax,
              ),
              const SizedBox(width: 5),
              Text(
                Const.coinName,
                style: AppTextStyles.titleMin,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${AppLocalizations.of(context)!.incoming}: 0.000000',
            style: AppTextStyles.titleMin.copyWith(fontSize: 16.0, color: Colors.white.withOpacity(0.9)),
          ),
          Text(
            '${AppLocalizations.of(context)!.outgoing}: 0.000000',
            style: AppTextStyles.titleMin.copyWith(fontSize: 16.0, color: Colors.white.withOpacity(0.9)),
          ),
       /*    Row(
                children: [
                  const ItemHeaderInfo(title: "USDT", value: "0"),
                  ItemHeaderInfo(
                      title: AppLocalizations.of(context)!.incoming,
                      value: "0"),
                  ItemHeaderInfo(
                      title: AppLocalizations.of(context)!.outgoing,
                      value: "0"),
                ],
              ),

        */
          const SizedBox(height: 30),
        ],
      );
    });
  }
}

class ItemHeaderInfo extends StatelessWidget {
  final String title, value;

  const ItemHeaderInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: TextButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.2),
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            Text(
              '$title: $value',
              style: AppTextStyles.titleMin.copyWith(fontSize: 16.0, color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}


