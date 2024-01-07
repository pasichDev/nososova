import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../common/components/empty_list_widget.dart';
import '../../../common/route/dialog_router.dart';
import '../../../common/route/page_router.dart';
import '../../../tiles/tile_wallet_address.dart';

class ListAddresses extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ListAddresses({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final wallets = state.wallet.address;
        if(wallets.isEmpty){
          return Expanded(
              flex: 2,
              child:Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.white,
                child: Center(
                    child: EmptyWidget(
                        title: AppLocalizations.of(context)!.empty,
                        descrpt: AppLocalizations.of(context)!.emptyListAddress)),
              ));
        }
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
                    onTap: () =>
                        PageRouter.routeAddressInfoPage(context, address),
                    onLong: () =>
                        DialogRouter.showDialogAddressActions(context, address, scaffoldKey),
                  );
                }));
      },
    );
  }
}
