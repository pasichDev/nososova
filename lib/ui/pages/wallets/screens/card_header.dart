import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nososova/blocs/coin_info_bloc.dart';
import 'package:nososova/utils/const/const.dart';
import 'package:nososova/utils/status_api.dart';

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
      child: const SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: CardBody()),
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

          ItemTotalPrice(totalPrice:  state.wallet.balanceTotal),
          const SizedBox(height: 10),
          Text(
            '${AppLocalizations.of(context)!.incoming}: ${state.wallet.totalIncoming}',
            style: AppTextStyles.titleMin
                .copyWith(fontSize: 16.0, color: Colors.white.withOpacity(0.9)),
          ),
          Text(
            '${AppLocalizations.of(context)!.outgoing}: ${state.wallet.totalOutgoing}',
            style: AppTextStyles.titleMin
                .copyWith(fontSize: 16.0, color: Colors.white),
          ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}



class ItemTotalPrice extends StatelessWidget {
  final double totalPrice;
  const ItemTotalPrice({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CoinInfoBloc, CoinInfoState>(builder: (context, state) {
      var priceMoney = state.infoCoin.minimalInfo?.rate ?? 0;
      var price = totalPrice * priceMoney;
      return Row(children : [
        if(state.apiPriceStatus == ApiStatus.connected)    Text(
          "${price.toStringAsFixed(2)} USDT",
          style: AppTextStyles.titleMin
              .copyWith(color: Colors.white.withOpacity(0.5)),
        ),
        const SizedBox(width: 10),
      if(state.apiPriceStatus == ApiStatus.loading)  LoadingAnimationWidget.prograssiveDots(
         color: Colors.white.withOpacity(0.5), size: 26,
        ),
      ]);});
  }
}