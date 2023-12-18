import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nososova/blocs/app_data_bloc.dart';

import '../../../utils/status_api.dart';
import '../../theme/style/text_style.dart';

class ItemTotalPrice extends StatelessWidget {
  final double totalPrice;

  const ItemTotalPrice({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      var priceMoney = state.statisticsCoin.getCurrentPrice;
      var price = totalPrice * priceMoney;
      return Row(children: [
        if (state.statisticsCoin.apiStatus == ApiStatus.connected)
          Text(
            "${price.toStringAsFixed(2)} USDT",
            style: AppTextStyles.titleMin
                .copyWith(color: Colors.white.withOpacity(0.5)),
          ),
        const SizedBox(width: 10),
        if (state.statisticsCoin.apiStatus == ApiStatus.loading)
          LoadingAnimationWidget.prograssiveDots(
            color: Colors.white.withOpacity(0.5),
            size: 26,
          ),
      ]);
    });
  }
}
