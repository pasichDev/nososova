import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/pages/wallets/screens/card_header.dart';
import 'package:nososova/ui/dialogs/dialog_wallet_actions.dart';
import 'package:nososova/ui/pages/wallets/screens/list_wallets.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../utils/const/files_const.dart';


class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  WalletsPageState createState() => WalletsPageState();
}


class WalletsPageState extends  State<WalletsPage> {
  late WalletBloc walletBloc;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    walletBloc.actionsFileWallet.listen((message) {
      if (kDebugMode) {
        print(message);
      }

      if (message == ActionsFileWallet.walletOpen) {
        // Відкрити діалогове вікно для "walletOpen"
      } else {
        var textError = "";
        Color snackBarBackgroundColor = message == ActionsFileWallet.fileNotSupported ? Colors.red : Colors.black; // Визначаємо колір в залежності від умови

        switch (message) {
          case ActionsFileWallet.isFileEmpty:
            textError = "Це файл не містить адрес";
            break;
          case ActionsFileWallet.fileNotSupported:
            textError = "Цей файл не підтримується";
            break;
          default:
            textError = "Невідома помилка";
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            textError,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          backgroundColor: snackBarBackgroundColor,
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardHeader(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: const HeaderMyWallets(),
          ),
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
      return DialogWalletActions(walletBloc: walletBloc);
    },
  );
}





