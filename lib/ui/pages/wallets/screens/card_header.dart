import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/utils/const/const.dart';

import '../../../../blocs/wallet_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/responsive.dart';
import '../../../theme/anim/blinkin_widget.dart';
import '../../../theme/decoration/standart_gradient_decoration.dart';
import '../../../theme/decoration/standart_gradient_decoration_round.dart';
import '../../../theme/style/colors.dart';
import '../../../theme/style/text_style.dart';
import '../widgets/total_usdt_price.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return !Responsive.isMobile(context)
        ? Container(
            height: 300,
            width: double.infinity,
            decoration: !Responsive.isMobile(context)
                ? const HomeGradientDecoration()
                : const HomeGradientDecorationRound(),
            child: const SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: CardBody()),
            ),
          )
        : Container(
            width: double.infinity,
            decoration: !Responsive.isMobile(context)
                ? const HomeGradientDecoration()
                : const HomeGradientDecorationRound(),
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
      var isOutgoing = state.wallet.totalOutgoing > 0;
      var isIncoming =  state.wallet.totalIncoming > 0;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.balance,
            style: AppTextStyles.walletAddress
                .copyWith(fontSize: 22, color: Colors.white.withOpacity(0.5)),
          ),
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
          ItemTotalPrice(totalPrice: state.wallet.balanceTotal),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.incoming,
                    style: AppTextStyles.titleMin.copyWith(
                        fontSize: 16.0, color: Colors.white.withOpacity(0.5)),
                  ),
                  BlinkingWidget(
                      widget: Text(
                         state.wallet.totalIncoming.toStringAsFixed(8),
                          style: AppTextStyles.categoryStyle.copyWith(
                              fontSize: 16,
                              color: isIncoming
                                  ? CustomColors.positiveBalance
                                  : Colors.white.withOpacity(0.8))),
                      startBlinking: isIncoming,
                      duration: 1000)

                ],
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.outgoing,
                    style: AppTextStyles.titleMin.copyWith(
                        fontSize: 16.0, color: Colors.white.withOpacity(0.5)),
                  ),
                  BlinkingWidget(
                      widget: Text(
                         state.wallet.totalOutgoing.toStringAsFixed(8),
                          style: AppTextStyles.categoryStyle.copyWith(
                              fontSize: 16,
                              color: isOutgoing
                                  ? CustomColors.negativeBalance
                                  : Colors.white.withOpacity(0.8))),
                      startBlinking: isOutgoing,
                      duration: 1000)

                ],
              )
            ],
          ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}
