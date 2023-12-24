import 'package:flutter/material.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/ui/common/widgets/widget_transaction.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../theme/style/text_style.dart';

class TransactionDialog {
  WoltModalSheetPage showDialog(BuildContext modalSheetContext, TransactionHistory transaction, bool isReceiver) {
    return WoltModalSheetPage(
      backgroundColor: Colors.white,
        hasSabGradient: false,
        topBarTitle: Text( AppLocalizations.of(modalSheetContext)!.transactionInfo, textAlign: TextAlign.center, style: AppTextStyles.walletAddress.copyWith()),
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(20),
          icon: const Icon(Icons.close),
          onPressed: Navigator.of(modalSheetContext).pop,
        ),
        child: TransactionWidgetInfo(
          transaction: transaction,
          isReceiver: isReceiver,
        ));
  }

}