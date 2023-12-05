import 'package:flutter/material.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../generated/assets.dart';
import '../../utils/other_utils.dart';
import '../theme/style/colors.dart';

class TransactionTile extends StatefulWidget {
  final VoidCallback onTap;
  final TransactionHistory transactionHistory;
  final bool receiver;

  const TransactionTile({
    Key? key,
    required this.transactionHistory,
    required this.onTap,
    required this.receiver,
  }) : super(key: key);

  @override
  TransactionTileState createState() => TransactionTileState();
}

class TransactionTileState extends State<TransactionTile> {

  bool isCustom = false;
  @override
  void initState() {
    super.initState();
    isCustom = widget.transactionHistory.type == "CUSTOM";
  }

  Widget _iconAddress() {
    if(isCustom){
      return AppIconsStyle.icon3x2(Assets.iconsRename);
    }
    if (widget.receiver) {
      return AppIconsStyle.icon3x2(Assets.iconsInput);
    }
    return AppIconsStyle.icon3x2(Assets.iconsOutput);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _iconAddress(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child:

            Text(
              OtherUtils.hashObfuscation(
                  widget.receiver
                  ? widget.transactionHistory.sender
                  : widget.transactionHistory.receiver),
              style: AppTextStyles.walletAddress.copyWith(
                fontFamily: "GilroyRegular",
              ),
            ),
          ),
          Text(
            "${widget.receiver ? "+" : "-"} ${(double.parse(widget.transactionHistory.amount) + double.parse(widget.transactionHistory.fee)).toStringAsFixed(8)}",
            style: AppTextStyles.walletAddress.copyWith(
              color: widget.receiver
                  ? CustomColors.positiveBalance
                  : CustomColors.negativeBalance,
            ),
          ),
        ],
      ),
      onTap: widget.onTap,
    );
  }

/*
  getOrderAmount(){
    return   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.address.balance.toStringAsFixed(3),
            style: AppTextStyles.walletAddress,
          ),
          if (widget.address.incoming > 0)
            Text(
              "+ ${widget.address.incoming}",
              style: AppTextStyles.itemStyle.copyWith(
                  fontSize: 16,
                  fontFamily: "GilroySemiBold",
                  color: Colors.green),
            ),
          const SizedBox(width: 5),
          if (widget.address.outgoing > 0)
            Text(
              "- ${widget.address.outgoing}",
              style: AppTextStyles.itemStyle.copyWith(
                  fontSize: 16,
                  fontFamily: "GilroySemiBold",
                  color: Colors.red),
            ),
        ]);
  }

 */
}
