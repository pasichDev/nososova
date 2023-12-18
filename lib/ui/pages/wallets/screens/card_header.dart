import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/utils/const/const.dart';

import '../../../../blocs/wallet_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common/widgets/total_usdt_price.dart';
import '../../../theme/decoration/standart_gradient_decoration_round.dart';
import '../../../theme/style/text_style.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const HomeGradientDecorationRound(),
      child: const SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0), child: CardBody()),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({super.key});

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
          ItemTotalPrice(totalPrice: state.wallet.balanceTotal),
          const SizedBox(height: 10),
          Text(
            '${AppLocalizations.of(context)!.incoming}: ${state.wallet.totalIncoming.toStringAsFixed(8)}',
            style: AppTextStyles.titleMin
                .copyWith(fontSize: 16.0, color: Colors.white.withOpacity(0.9)),
          ),
          Text(
            '${AppLocalizations.of(context)!.outgoing}: ${state.wallet.totalOutgoing.toStringAsFixed(8)}',
            style: AppTextStyles.titleMin
                .copyWith(fontSize: 16.0, color: Colors.white),
          ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}
