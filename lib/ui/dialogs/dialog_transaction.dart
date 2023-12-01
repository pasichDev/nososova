import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/apiExplorer/transaction_history.dart';
import '../theme/style/text_style.dart';

class DialogTransaction extends StatefulWidget {
  final TransactionHistory transactionHistory;

  const DialogTransaction({Key? key, required this.transactionHistory})
      : super(key: key);

  @override
  DialogTransactionState createState() => DialogTransactionState();
}

class DialogTransactionState extends State<DialogTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.transactionInfo,
            style: AppTextStyles.dialogTitle,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ваш зміст тут
              const SizedBox(height: 20),
            ],
          ),
        ),

    );
  }
}
