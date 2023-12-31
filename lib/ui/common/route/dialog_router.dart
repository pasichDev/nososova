import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/ui/dialogs/address_action/dialog_view_keyspair.dart';
import 'package:nososova/utils/noso/model/address_object.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../blocs/app_data_bloc.dart';
import '../../../blocs/debug_bloc.dart';
import '../../../blocs/wallet_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../../config/responsive.dart';
import '../../dialogs/address_action/dialog_address_info.dart';
import '../../dialogs/address_action/dialog_custom_name.dart';
import '../../dialogs/address_action/dialog_view_qr.dart';
import '../../dialogs/dialog_debug.dart';
import '../../dialogs/dialog_info_network.dart';
import '../../dialogs/dialog_wallet_actions.dart';
import '../../dialogs/import_export/dialog_import_address.dart';
import '../../dialogs/import_export/dialog_import_keys_pair.dart';
import '../../dialogs/import_export/dialog_scanner_qr.dart';
import '../../theme/style/dialog_style.dart';
import '../../theme/style/text_style.dart';

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
  static void showDialogActionWallet(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    showModalBottomSheet(
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<WalletBloc>(context),
            child: DialogWalletActions(scaffoldKey: scaffoldKey)));
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
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (BuildContext _) {
        return [
          WoltModalSheetPage(
              backgroundColor: Colors.white,
              hasSabGradient: false,
              topBarTitle: Text(AppLocalizations.of(context)!.importKeysPair,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.walletAddress.copyWith(fontSize: 20)),
              isTopBarLayerAlwaysVisible: true,
              child: BlocProvider.value(
                value: BlocProvider.of<WalletBloc>(context),
                child: const DialogImportKeysPair(),
              ))
        ];
      },
    );
  }

  /// A dialog in which actions on the address are provided
  static void showDialogAddressActions(BuildContext context, Address address,
      GlobalKey<ScaffoldState> scaffoldKey) {
    if (Responsive.isMobile(context)) {
      showModalBottomSheet(
          shape: DialogStyle.borderShape,
          context: context,
          builder: (_) => BlocProvider.value(
              value: BlocProvider.of<WalletBloc>(context),
              child: AddressInfo(
                address: address,
                scaffoldKey: scaffoldKey,
              )));
    } else {
      WoltModalSheet.show(
        context: context,
        pageListBuilder: (BuildContext _) {
          return [
            WoltModalSheetPage(
                backgroundColor: Colors.white,
                hasSabGradient: false,
                topBarTitle: Text(address.hashPublic,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.walletAddress.copyWith(fontSize: 20)),
                isTopBarLayerAlwaysVisible: true,
                child: BlocProvider.value(
                    value: BlocProvider.of<WalletBloc>(context),
                    child: AddressInfo(
                      address: address,
                      scaffoldKey: scaffoldKey,
                    )))
          ];
        },
      );
    }
  }

  /// Dialog for viewing the qr code of the address
  static void showDialogViewQr(BuildContext context, Address address) {
    if (Responsive.isMobile(context)) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => SafeArea(child: DialogViewQrWidget(address: address)),
      );
    } else {
      WoltModalSheet.show(
        context: context,
        pageListBuilder: (BuildContext _) {
          return [
            WoltModalSheetPage(
                backgroundColor: Colors.white,
                hasSabGradient: false,
                topBarTitle: Text(address.hashPublic,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.walletAddress.copyWith(fontSize: 20)),
                isTopBarLayerAlwaysVisible: true,
                child: DialogViewQrWidget(address: address))
          ];
        },
      );
    }
  }

  /// Dialog for setting alias
  static void showDialogCustomName(BuildContext context, Address address) {
    if (Responsive.isMobile(context)) {
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
    } else {
      WoltModalSheet.show(
        context: context,
        pageListBuilder: (BuildContext _) {
          return [
            WoltModalSheetPage(
                backgroundColor: Colors.white,
                hasSabGradient: false,
                topBarTitle: Text(AppLocalizations.of(context)!.customNameAdd,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.walletAddress.copyWith(fontSize: 20)),
                isTopBarLayerAlwaysVisible: true,
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: BlocProvider.of<WalletBloc>(context),
                    ),
                  ],
                  child: DialogCustomName(address: address),
                ))
          ];
        },
      );
    }
  }


  /// Dialog in which debug information is displayed
  static void showDialogDebug(BuildContext context) {
    showModalBottomSheet(
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => BlocProvider.value(
              value: BlocProvider.of<DebugBloc>(context),
              child: const DialogDebug(),
            ));
  }

  /// Dialog in which list address to import file
  static void showDialogImportFile(
      BuildContext context, List<Address> address) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<WalletBloc>(context),
            child: DialogImportAddress(address: address)));
  }


  static void showDialogViewKeysPair(BuildContext context, Address address) {
    WoltModalSheet.show(
      context: context,
      minDialogWidth: 600,
      pageListBuilder: (BuildContext _) {
        return [
          WoltModalSheetPage(
            backgroundColor: Colors.white,
            hasSabGradient: false,
            topBarTitle: Text("Secret keys",
                textAlign: TextAlign.center,
                style: AppTextStyles.walletAddress.copyWith(fontSize: 20)),
            isTopBarLayerAlwaysVisible: true,
            child: DialogViewKeysPair(address: address),
          )
        ];
      },
    );
  }
}
