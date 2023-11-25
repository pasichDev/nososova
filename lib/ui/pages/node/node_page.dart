import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/blocs/node_bloc.dart';
import 'package:nososova/ui/pages/node/screens/list_nodes.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../../generated/assets.dart';
import '../../../l10n/app_localizations.dart';
import '../../theme/decoration/other_gradient_decoration.dart';
import '../../theme/style/colors.dart';

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
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(20), child: headerContent())),
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
                height: MediaQuery.of(context).size.height * 0.55,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(  AppLocalizations.of(context)!.masternode,
                                style: AppTextStyles.categoryStyle),
                            SvgPicture.asset(
                              Assets.iconsInfo,
                              width: 24,
                              height: 24,
                              color: CustomColors.primaryColor,
                            ),
                          ]),
                    ),
                    // const SizedBox(height: 10),
                    const ListNodes()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  headerContent() {
    return BlocBuilder<NodeBloc, NodeState>(builder: (context, state) {
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
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.stateNode.nodes.length.toString(),
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.white, fontSize: 24),
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
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.stateNode.launchedNodes.toString(),
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.white, fontSize: 24),
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
                  AppLocalizations.of(context)!.rewardNodeLaunched,
                  style: AppTextStyles.itemStyle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  "${state.stateNode.rewardDay.toStringAsFixed(6)} NOSO",
                  style: AppTextStyles.walletAddress
                      .copyWith(color: Colors.white, fontSize: 24),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
