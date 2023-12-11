import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/assets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/const/const.dart';
import '../../../../utils/custom_class/dasher_divider.dart';
import '../../../../utils/other_utils.dart';
import '../../../components/info_item.dart';
import '../../../theme/style/text_style.dart';

class TransactionPage extends StatefulWidget {
  final TransactionHistory transaction;
  final bool isReceiver;

  const TransactionPage(
      {Key? key, required this.transaction, required this.isReceiver})
      : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<TransactionPage> {
  bool isCustom = false;
  late Uri urlShare;

  @override
  void initState() {
    super.initState();
    isCustom = widget.transaction.type == "CUSTOM";
    urlShare = Uri.parse(
        "https://explorer.nosocoin.com/getordersinfo.html?orderid=${widget.transaction.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.transactionInfo,
          style: AppTextStyles.dialogTitle,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Container(
                  color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: isCustom
                                ? Colors.grey.withOpacity(0.2)
                                : widget.isReceiver
                                    ? const Color(0xffd6faeb)
                                    : const Color(0xfff2d3ce),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: SvgPicture.asset(
                            isCustom
                                ? Assets.iconsRename
                                : widget.isReceiver
                                    ? Assets.iconsExport
                                    : Assets.iconsImport,
                            width: 80,
                            height: 80,
                            color: isCustom
                                ? Colors.black
                                : widget.isReceiver
                                    ? CustomColors.positiveBalance
                                    : CustomColors.negativeBalance,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                            isCustom
                                ? AppLocalizations.of(context)!.editCustom
                                : "${widget.isReceiver ? "+" : "-"}${widget.transaction.amount.replaceAll(' ', '')} ${Const.coinName}",
                            style: AppTextStyles.titleMax
                                .copyWith(color: Colors.black, fontSize: 36)),
                        const SizedBox(height: 20),
                        Text(
                            "${AppLocalizations.of(context)!.block}: ${widget.transaction.blockId.toString()}",
                            style: AppTextStyles.walletAddress
                                .copyWith(color: Colors.black, fontSize: 20)),
                        const SizedBox(height: 10),
                        Text(widget.transaction.timestamp,
                            style: AppTextStyles.itemStyle
                                .copyWith(color: Colors.grey)),
                        const SizedBox(height: 20),
                        const DasherDivider(
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        InfoItem().itemInfo(
                            AppLocalizations.of(context)!.orderId,
                            widget.transaction.obfuscationOrderId),
                        if (!widget.isReceiver)
                          InfoItem().itemInfo(
                              AppLocalizations.of(context)!.receiver,
                              OtherUtils.hashObfuscation(
                                  widget.transaction.receiver)),
                        if (widget.isReceiver)
                          InfoItem().itemInfo(
                              AppLocalizations.of(context)!.sender,
                              OtherUtils.hashObfuscation(
                                  widget.transaction.sender)),
                        if (!widget.isReceiver)
                          InfoItem().itemInfo(
                              AppLocalizations.of(context)!.commission,
                              "${widget.transaction.fee} ${Const.coinName}"),
                        if (isCustom)
                          InfoItem().itemInfo(
                              AppLocalizations.of(context)!.message, "CUSTOM"),
                      ],
                    )),
              )),
          const SizedBox(height: 20),
          buttonAction(AppLocalizations.of(context)!.openToExplorer,
              () => runExplorer()),
          const SizedBox(height: 10),
          buttonAction(AppLocalizations.of(context)!.shareTransaction,
              () => shareLinkExplorer()),
        ],
      ),
    );
  }

  buttonAction(String text, Function onTap) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () => onTap(),
          style: OutlinedButton.styleFrom(
            side:  BorderSide(color: Colors.black.withOpacity(0.2)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                text,
                style: AppTextStyles.walletAddress
                    .copyWith(color: Colors.black, fontSize: 18),
              )),
        ));
  }

  runExplorer() async {
    if (await canLaunchUrl(urlShare)) {
      await launchUrl(urlShare);
    } else {
      throw 'Could not launch $urlShare';
    }
  }

  shareLinkExplorer() async {
    Share.share(urlShare.toString());
  }
}
