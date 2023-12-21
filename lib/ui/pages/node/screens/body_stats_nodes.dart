import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/wallet_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../theme/style/text_style.dart';

class StatsNodesUser extends StatelessWidget {
  const StatsNodesUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.available,
                        style: AppTextStyles.itemStyle
                            .copyWith(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.stateNodes.nodes.length.toString(),
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.white, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.launched,
                        style: AppTextStyles.itemStyle
                            .copyWith(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.stateNodes.launchedNodes.toString(),
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.white, fontSize: 22),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.nr24,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.itemStyle
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  "${state.stateNodes.rewardDay.toStringAsFixed(6)} NOSO",
                  style: AppTextStyles.walletAddress
                      .copyWith(color: Colors.white, fontSize: 22),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
