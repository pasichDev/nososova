import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/utils/noso/model/address_object.dart';

import '../../../blocs/app_data_bloc.dart';
import '../../../blocs/debug_bloc.dart';
import '../../../blocs/wallet_bloc.dart';
import '../../dialogs/address_action/dialog_address_info.dart';
import '../../dialogs/address_action/dialog_custom_name.dart';
import '../../dialogs/address_action/dialog_view_qr.dart';
import '../../dialogs/dialog_debug.dart';
import '../../dialogs/dialog_info_network.dart';
import '../../dialogs/dialog_wallet_actions.dart';
import '../../dialogs/import_export/dialog_import_keys_pair.dart';
import '../../dialogs/import_export/dialog_scanner_qr.dart';
import '../../theme/style/dialog_style.dart';

class DialogRouter {
  /// The dialog that displays the qr Codes scanner
  static void showDialogScanQr(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => BlocProvider.value(
          value: BlocProvider.of<WalletBloc>(context),
          child: const ScannerQrWidget()),
    );
  }

  /// The dialog that displays possible actions on the wallet
  static void showDialogActionWallet(BuildContext context) {
    showModalBottomSheet(
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<WalletBloc>(context),
            child: const DialogWalletActions()));
  }

  /// The dialog that displays the status of the network connection and actions on it
  static void showDialogInfoNetwork(BuildContext context) {
    showModalBottomSheet(
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<AppDataBloc>(context),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<DebugBloc>(context),
                ),
              ],
              child: const DialogInfoNetwork(),
            ));
  }

  /// The dialog that can be used to restore the address with a pair of keys
  static void showDialogImportAddressFromKeysPair(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Material(
          child: BlocProvider.value(
            value: BlocProvider.of<WalletBloc>(context),
            child: const DialogImportKeysPair(),
          ),
        ),
      ),
    );
  }

  /// A dialog in which actions on the address are provided
  static void showDialogAddressActions(BuildContext context, Address address) {
    showModalBottomSheet(
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<WalletBloc>(context),
            child: AddressInfo(
              address: address,
            )));
  }

  /// Dialog for viewing the qr code of the address
  static void showDialogViewQr(BuildContext context, Address address) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => SafeArea(child: DialogViewQrWidget(address: address)),
    );
  }

  /// Dialog for setting alias
  static void showDialogCustomName(BuildContext context, Address address) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<WalletBloc>(context),
                ),
              ],
              child: DialogCustomName(address: address),
            ));
  }

  /// Dialog in which debug information is displayed
  static void showDialogDebug(BuildContext context) {
  //  Navigator.of(context).pop();
    showModalBottomSheet(
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => BlocProvider.value(
              value: BlocProvider.of<DebugBloc>(context),
              child: const DialogDebug(),
            ));
  }
}
