import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/history_transactions_bloc.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/ui/pages/addressInfo/transaction/transaction_page.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';
import 'package:nososova/utils/noso/src/address_object.dart';
import 'package:nososova/utils/status_api.dart';

import '../../../../blocs/events/history_transactions_events.dart';
import '../../../../generated/assets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../components/empty_list_widget.dart';
import '../../../components/loading.dart';
import '../../../theme/style/colors.dart';
import '../../../theme/style/text_style.dart';
import '../../../tiles/tile_transaction.dart';

class HistoryTransactionsWidget extends StatefulWidget {
  final Address address;

  const HistoryTransactionsWidget({super.key, required this.address});

  @override
  HistoryTransactionWidgetsState createState() =>
      HistoryTransactionWidgetsState();
}

class HistoryTransactionWidgetsState extends State<HistoryTransactionsWidget> {
  final GlobalKey<HistoryTransactionWidgetsState> _historyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryTransactionsBloc>(context)
        .add(FetchHistory(widget.address.hash));
  }

  @override
  Widget build(BuildContext context) {
    print("recretedWidget");
    return BlocBuilder<HistoryTransactionsBloc, HistoryTransactionsBState>(
        key: _historyKey,
        builder: (context, state) {
          var listHistory = state.transactions;
          listHistory.sort((a, b) => b.blockId.compareTo(a.blockId));

          return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .catHistoryTransaction,
                                style: AppTextStyles.categoryStyle),
                            AppIconsStyle.icon2x4(Assets.iconsInfo,
                                colorCustom: CustomColors.primaryColor),
                          ])),
                  if (state.apiStatus == ApiStatus.error) ...[
                    const SizedBox(height: 200),
                    EmptyWidget(
                        title: AppLocalizations.of(context)!.errorLoading)
                  ],
                  if (state.apiStatus == ApiStatus.loading) ...[
                    const SizedBox(height: 200),
                    const LoadingWidget()
                  ],
                  if (state.apiStatus == ApiStatus.connected &&
                      listHistory.isEmpty) ...[
                    const SizedBox(height: 200),
                    EmptyWidget(title: AppLocalizations.of(context)!.empty)
                  ],
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

                          // Check if it's the first item or the date is different from the previous transaction
                          if (index == 0 ||
                              _isDifferentDate(
                                  listHistory[index - 1], transaction)) {
                            return Column(
                              children: [
                                // Date header
                                ListTile(
                                  title: Text(
                                      _getFormattedDate(transaction.timestamp),
                                      style: AppTextStyles.itemStyle.copyWith(
                                          color: Colors.black.withOpacity(0.7), fontSize: 18)),
                                  // Additional styling for date header if needed
                                ),
                                // Transaction item
                                TransactionTile(
                                  transactionHistory: transaction,
                                  receiver: isReceiver,
                                  onTap: () => _showTransactionInfo(
                                      context, transaction, isReceiver),
                                ),
                              ],
                            );
                          } else {
                            // Only transaction item (no date header)
                            return TransactionTile(
                              transactionHistory: transaction,
                              receiver: isReceiver,
                              onTap: () => _showTransactionInfo(
                                  context, transaction, isReceiver),
                            );
                          }
                        },
                      ),
                    )
                  ]
                ],
              ));
        });
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

    if (date.day == currentDate.day &&
        date.month == currentDate.month &&
        date.year == currentDate.year) {
      return AppLocalizations.of(context)!.today;
    } else if (date.day == currentDate.day - 1 &&
        date.month == currentDate.month &&
        date.year == currentDate.year) {
      return AppLocalizations.of(context)!.yesterday;
    } else {
      return '${date.day}-${date.month}-${date.year}';
    }
  }

  void _showTransactionInfo(
      BuildContext context, TransactionHistory transaction, bool isReceiver) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionPage(
          transaction: transaction,
          isReceiver: isReceiver,
        ),
      ),
    );
  }
}
