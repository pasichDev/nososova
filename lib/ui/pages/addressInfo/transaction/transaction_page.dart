import 'package:flutter/material.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/ui/pages/addressInfo/transaction/screen/widget_transaction.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../theme/style/text_style.dart';

class TransactionPage extends StatefulWidget {
  final TransactionHistory transaction;
  final bool isReceiver;

  const TransactionPage(
      {Key? key, required this.transaction, required this.isReceiver})
      : super(key: key);

  @override
  State createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
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
          children: [
            TransactionWidgetInfo(
              transaction: widget.transaction,
              isReceiver: widget.isReceiver,
            ),
            const SizedBox(height: 20),
            buttonAction(AppLocalizations.of(context)!.openToExplorer,
                () => runExplorer()),
            const SizedBox(height: 10),
            buttonAction(AppLocalizations.of(context)!.shareTransaction,
                () => shareLinkExplorer()),
          ],
        ));
  }

  buttonAction(String text, Function onTap) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () => onTap(),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.black.withOpacity(0.2)),
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
