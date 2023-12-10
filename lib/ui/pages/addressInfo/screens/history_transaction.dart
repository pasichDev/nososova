import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/history_transactions_bloc.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/ui/pages/addressInfo/transaction/transaction_page.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';
import 'package:nososova/utils/status_api.dart';

import '../../../../blocs/events/history_transactions_events.dart';
import '../../../../generated/assets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/noso/src/address_object.dart';
import '../../../components/empty_list_widget.dart';
import '../../../components/loading.dart';
import '../../../theme/style/colors.dart';
import '../../../theme/style/text_style.dart';
import '../../../tiles/tile_transaction.dart';

class HistoryTransactionsWidget extends StatefulWidget {
  final Address address;

  const HistoryTransactionsWidget({super.key, required this.address});

  @override
  HistoryTransactionsState createState() => HistoryTransactionsState();
}

class HistoryTransactionsState extends State<HistoryTransactionsWidget> {
  final GlobalKey<HistoryTransactionsState> _historyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryTransactionsBloc>(context)
        .add(FetchHistory(widget.address.hash));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryTransactionsBloc, HistoryTransactionsBState>(
        key: _historyKey,
        builder: (context, state) {
          var listHistory = state.transactions;
          listHistory.sort((a, b) => b.blockId.compareTo(a.blockId));
          return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .pendings,
                                style: AppTextStyles.categoryStyle),

                          ])),

                  Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                    Column(children: [
                      Text(
                          AppLocalizations.of(context)!
                              .incoming,
                          style: AppTextStyles.itemStyle),
                      Text(
                          widget.address.incoming.toStringAsFixed(8),
                          style: AppTextStyles.categoryStyle.copyWith(fontSize: 20)),
                    ],),
                    const SizedBox(width: 60),
                    Column(children: [
                      Text(
                          AppLocalizations.of(context)!
                              .outgoing,
                          style: AppTextStyles.itemStyle),
                      Text(
                          widget.address.outgoing.toStringAsFixed(8),
                          style: AppTextStyles.categoryStyle.copyWith(fontSize: 20)),
                    ],)
                  ],),

                  Padding(
                      padding: const EdgeInsets.all(20),
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
                              return TransactionTile(
                                transactionHistory: transaction,
                                receiver: isReceiver,
                                onTap: () => _showTransactionInfo(
                                    context, transaction, isReceiver),
                              );
                            }))
                  ]
                ],
              ));
        });
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
