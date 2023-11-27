import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/dialogs/dialog_wallet_actions.dart';
import 'package:nososova/ui/pages/wallets/screens/card_header.dart';
import 'package:nososova/ui/pages/wallets/screens/list_addresses.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../generated/assets.dart';
import '../../../utils/const/files_const.dart';
import '../../dialogs/import_export/dialog_import_address.dart';
import '../../theme/style/dialog_style.dart';
import '../../theme/style/text_style.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  WalletsPageState createState() => WalletsPageState();
}

class WalletsPageState extends State<WalletsPage> {
  late WalletBloc walletBloc;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    _importAddressSituation();
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
          const ListAddresses(),
        ],
      ),
    );
  }

  void _importAddressSituation() {
    walletBloc.actionsFileWallet.listen((message) {
      if (message.actionsFileWallet == ActionsFileWallet.walletOpen) {
        showModalBottomSheet(
            shape: DialogStyle.borderShape,
            context: context,
            builder: (_) => BlocProvider.value(
                value: walletBloc,
                child: DialogImportAddress(address: message.address)));
      } else {
        var textError = "";
        Color snackBarBackgroundColor =
            message.actionsFileWallet == ActionsFileWallet.fileNotSupported
                ? Colors.red
                : Colors.black;

        switch (message.actionsFileWallet) {
          case ActionsFileWallet.isFileEmpty:
            textError = AppLocalizations.of(context)!.errorEmptyListWallet;
            break;
          case ActionsFileWallet.fileNotSupported:
            textError = AppLocalizations.of(context)!.errorNotSupportedWallet;
            break;
          case ActionsFileWallet.addressAdded:
            textError =
                "${AppLocalizations.of(context)!.addressesAdded} ${message.value}";
            break;
          default:
            textError = AppLocalizations.of(context)!.unknownError;
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
}

class HeaderMyWallets extends StatelessWidget {
  const HeaderMyWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppLocalizations.of(context)!.myAddresses,
            style: AppTextStyles.categoryStyle),
        Row(
          children: [
            IconButton(
                icon: SvgPicture.asset(
                  Assets.iconsMenu,
                  width: 24,
                  height: 24,
                  color: CustomColors.primaryColor,
                ),
                onPressed: () {
                  _showBottomSheetAddMyWallets(
                      context, BlocProvider.of<WalletBloc>(context));
                }),
          ],
        ),
      ],
    );
  }
}

void _showBottomSheetAddMyWallets(BuildContext context, WalletBloc walletBloc) {
  showModalBottomSheet(
    shape: DialogStyle.borderShape,
    context: context,
    builder: (BuildContext context) {
      return DialogWalletActions(walletBloc: walletBloc);
    },
  );
}
