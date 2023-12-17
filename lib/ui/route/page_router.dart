import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/utils/noso/model/address_object.dart';

import '../../blocs/app_data_bloc.dart';
import '../../blocs/history_transactions_bloc.dart';
import '../../blocs/wallet_bloc.dart';
import '../../dependency_injection.dart';
import '../../models/apiExplorer/transaction_history.dart';
import '../../repositories/repositories.dart';
import '../pages/addressInfo/address_info_page.dart';
import '../pages/addressInfo/transaction/transaction_page.dart';
import '../pages/payment/payment_page.dart';

class PageRouter {
  /// Page for sending payment
  static void routePaymentPage(BuildContext context, Address address) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<WalletBloc>(context),
          child: PaymentPage(address: address),
        ),
      ),
    );
  }

  /// Address information page
  static void routeAddressInfoPage(BuildContext context, Address address) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: locator<WalletBloc>(),
            ),
            BlocProvider.value(
              value: locator<AppDataBloc>(),
            ),
            BlocProvider<HistoryTransactionsBloc>(
              create: (BuildContext context) => HistoryTransactionsBloc.create(
                locator<Repositories>(),
                locator<WalletBloc>(),
              ),
            ),
          ],
          child: AddressInfoPage(hash: address.hash),
        ),
      ),
    );
  }

  /// Transaction information page
  static void showTransactionInfo(
      BuildContext context, TransactionHistory transaction, bool isReceiver) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionPage(
          transaction: transaction,
          isReceiver: isReceiver,
        ),
      ),
    );
  }
}
