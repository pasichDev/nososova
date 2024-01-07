import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nososova/blocs/history_transactions_bloc.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/utils/status_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../models/address_wallet.dart';
import '../../../common/components/empty_list_widget.dart';
import '../../../common/components/loading.dart';
import '../../../common/route/page_router.dart';
import '../../../theme/style/text_style.dart';
import '../../../tiles/tile_transaction.dart';

class HistoryTransactionsWidget extends StatefulWidget {
  final Address address;

  const HistoryTransactionsWidget({super.key, required this.address});

  @override
  State createState() => _HistoryTransactionWidgetsState();
}

class _HistoryTransactionWidgetsState extends State<HistoryTransactionsWidget> {
  final GlobalKey<_HistoryTransactionWidgetsState> _historyKey = GlobalKey();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<HistoryTransactionsBloc, HistoryTransactionsBState>(
            key: _historyKey,
            builder: (context, state) {
              var listHistory = state.transactions;
              listHistory.sort((a, b) => b.blockId.compareTo(a.blockId));

              if (state.apiStatus == ApiStatus.error ||
                  listHistory.isEmpty && state.apiStatus != ApiStatus.loading) {
                return getStackMessage(EmptyWidget(
                    title: AppLocalizations.of(context)!.unknownError,
                    descrpt: AppLocalizations.of(context)!
                        .errorEmptyHistoryTransactions));
              }
              if (state.apiStatus == ApiStatus.loading) {
                return getStackMessage(const LoadingWidget());
              }

              return Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .catHistoryTransaction,
                                    style: AppTextStyles.categoryStyle),
                              ])),
                      if (state.apiStatus == ApiStatus.connected) ...[
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          itemCount: listHistory.length,
                          itemBuilder: (context, index) {
                            final transaction = listHistory[index];
                            var isReceiver =
                                widget.address.hash == transaction.receiver;

                            if (index == 0 ||
                                _isDifferentDate(
                                    listHistory[index - 1], transaction)) {
                              return Column(
                                children: [
                                  // Date header
                                  ListTile(
                                    title: Text(
                                        _getFormattedDate(
                                            transaction.timestamp),
                                        style: AppTextStyles.itemStyle.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.9),
                                            fontSize: 18)),
                                  ),
                                  TransactionTile(
                                    transactionHistory: transaction,
                                    receiver: isReceiver,
                                    onTap: () => PageRouter.showTransactionInfo(
                                        context, transaction, isReceiver),
                                  ),
                                ],
                              );
                            } else {
                              return TransactionTile(
                                transactionHistory: transaction,
                                receiver: isReceiver,
                                onTap: () => PageRouter.showTransactionInfo(
                                    context, transaction, isReceiver),
                              );
                            }
                          },
                        )),
                      ]
                    ],
                  ));
            })
      ],
    );
  }

  getStackMessage(Widget widget) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Stack(children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.catHistoryTransaction,
                        style: AppTextStyles.categoryStyle),
                  ])),
          widget
        ]));
  }

  bool _isDifferentDate(TransactionHistory prevTransaction,
      TransactionHistory currentTransaction) {
    final prevDate = DateTime.parse(prevTransaction.timestamp).toLocal();
    final currentDate = DateTime.parse(currentTransaction.timestamp).toLocal();
    return prevDate.day != currentDate.day ||
        prevDate.month != currentDate.month ||
        prevDate.year != currentDate.year;
  }

  String _getFormattedDate(String timestamp) {
    final date = DateTime.parse(timestamp).toLocal();
    final currentDate = DateTime.now().toLocal();

    if (date.year == currentDate.year) {
      String dayMonth =
          DateFormat('d MMMM', Localizations.localeOf(context).toString())
              .format(date);
      if (date.day == currentDate.day &&
          date.month == currentDate.month &&
          date.year == currentDate.year) {
        return AppLocalizations.of(context)!.today;
      } else if (date.day == currentDate.day - 1 &&
          date.month == currentDate.month &&
          date.year == currentDate.year) {
        return AppLocalizations.of(context)!.yesterday;
      } else {
        return dayMonth;
      }
    } else {
      return DateFormat(
              'd MMMM yyyy', Localizations.localeOf(context).toString())
          .format(date);
    }
  }
}
