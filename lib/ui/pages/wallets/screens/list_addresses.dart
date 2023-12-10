import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/history_transactions_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/dependency_injection.dart';
import 'package:nososova/repositories/repositories.dart';

import '../../../theme/style/dialog_style.dart';
import '../../../tiles/tile_wallet_address.dart';
import '../../addressInfo/address_info_page.dart';
import '../dialogs/dialog_address_info.dart';

class ListAddresses extends StatelessWidget {
  const ListAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final wallets = state.wallet.address;
        return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                itemCount: wallets.length,
                itemBuilder: (_, index) {
                  final address = wallets[index];
                  return AddressListTile(
                    address: address,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: locator<WalletBloc>(),
                            ),
                            BlocProvider<HistoryTransactionsBloc>(
                              create: (BuildContext context) =>
                                  HistoryTransactionsBloc.create(
                                locator<Repositories>(),
                                locator<WalletBloc>(),
                              ),
                            ),
                          ],
                          child: AddressInfoPage(hash: address.hash),
                        ),
                      ),
                    ),
                    onLong: () {
                      showModalBottomSheet(
                          shape: DialogStyle.borderShape,
                          context: context,
                          builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<WalletBloc>(context),
                              child: AddressInfo(
                                address: address,
                              )));
                    },
                  );
                }));
      },
    );
  }
}
