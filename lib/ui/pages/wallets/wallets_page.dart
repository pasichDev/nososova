import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/dialogs/dialog_wallet_actions.dart';
import 'package:nososova/ui/pages/wallets/screens/card_header.dart';
import 'package:nososova/ui/pages/wallets/screens/list_addresses.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

import '../../../generated/assets.dart';
import '../../../utils/const/files_const.dart';
import '../../dialogs/import_export/dialog_import_address.dart';
import '../../responses_util/response_widget_id.dart';
import '../../responses_util/snackbar_message.dart';
import '../../theme/style/dialog_style.dart';
import '../../theme/style/text_style.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  WalletsPageState createState() => WalletsPageState();
}

class WalletsPageState extends State<WalletsPage> {
  late WalletBloc walletBloc;
  late StreamSubscription listenResponse;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    _responseListener();
  }

  void _responseListener() {
    listenResponse =
        walletBloc.getResponseStatusStream.listen((response) async {
      if (mounted ||
          ResponseWidgetsIds.idsPageWallet.contains(response.idWidget)) {
        if (response.action == ActionsFileWallet.walletOpen) {
          List<Address> address = response.actionValue;
          showModalBottomSheet(
              shape: DialogStyle.borderShape,
              context: context,
              builder: (_) => BlocProvider.value(
                  value: walletBloc,
                  child: DialogImportAddress(address: address)));
          return;
        }

        await Future.delayed(const Duration(milliseconds: 200));
        SnackBarWidgetResponse(context: context, response: response).get();
      }
    });
  }

/*
  void _importAddressSituation() {
    walletBloc.actionsFileWallet.listen((message) {
      if (message.actionsFileWallet == ActionsFileWallet.walletOpen) {

      } else {
        var textError = "";
        Color snackBarBackgroundColor =
            message.actionsFileWallet == ActionsFileWallet.fileNotSupported
                ? Colors.red
                : Colors.black;

        switch (message.actionsFileWallet) {
          case ActionsFileWallet.isFileEmpty:
            textError = AppLocalizations.of(context)!.errorEmptyListWallet; //5
            break;
          case ActionsFileWallet.fileNotSupported:
            textError = AppLocalizations.of(context)!.errorNotSupportedWallet; //6
            break;
          case ActionsFileWallet.addressAdded:
            textError =
                "${AppLocalizations.of(context)!.addressesAdded} ${message.value}"; //7
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


 */

  @override
  void dispose() {
    listenResponse.cancel();
    super.dispose();
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
