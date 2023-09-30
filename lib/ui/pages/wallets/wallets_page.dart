import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/pages/wallets/screens/card_header.dart';
import 'package:nososova/ui/pages/wallets/screens/dialogs/dialog_add_address.dart';
import 'package:nososova/ui/pages/wallets/screens/list_wallets.dart';
import 'package:nososova/ui/theme/style/colors.dart';

class WalletsPage extends StatelessWidget {
  const WalletsPage({super.key});


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CardHeader(),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: const HeaderMyWallets()),
            const ListWallets(),
          ],
        ),

    );

  }
}

class HeaderMyWallets extends StatelessWidget {
  const HeaderMyWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.myAddresses,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: const Icon(Icons.wallet, color: CustomColors.primaryColor),
                onPressed: () {
                  _showBottomSheetAddMyWallets(context, BlocProvider.of<WalletBloc>(context));
                }),
            IconButton(
                icon: const Icon(Icons.more_horiz, color: CustomColors.primaryColor),
                onPressed: () {
                 // _showBottomSheetMoreMyWallets(context);
                }),
          ],
        ),
      ],
    );
  }
}

void _showBottomSheetAddMyWallets(BuildContext context, WalletBloc walletBloc) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    context: context,
    builder: (BuildContext context) {
      return DialogAddAddress(walletBloc: walletBloc);
    },
  );
}





