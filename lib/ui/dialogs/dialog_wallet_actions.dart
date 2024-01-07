import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_saver_dev/flutter_file_saver_dev.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/generated/assets.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';

import '../../blocs/events/wallet_events.dart';
import '../../utils/files_const.dart';
import '../common/route/dialog_router.dart';
import '../config/responsive.dart';
import '../theme/style/text_style.dart';

class DialogWalletActions extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const DialogWalletActions({super.key,  this.scaffoldKey});

  @override
  State createState() => _DialogWalletActionsState();
}

class _DialogWalletActionsState extends State<DialogWalletActions> {
  late WalletBloc walletBloc;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
     /* if(Responsive.isMobile(context)) ...[
      Container(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey, width: 0.2),
          ),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: AppIconsStyle.icon3x2(Assets.iconsInfo),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!
                            .newFormatWalletFileDescrypt,
                        style: AppTextStyles.itemStyle.copyWith(fontSize: 16)),
                    TextSpan(
                        text: " .nososova",
                        style:
                            AppTextStyles.walletAddress.copyWith(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),]
      else ...[
      */
      Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Text(
            AppLocalizations.of(context)!.actionWallet,
            style: AppTextStyles.dialogTitle,
          )),
    //],
     SingleChildScrollView(child:  ListView(
        shrinkWrap: true,
        children: [
          buildListTileSvg(
              Assets.iconsWallet,
              AppLocalizations.of(context)!.genNewKeyPair,
              () => _createNewAddress(context)),
          buildListTileSvg(
              Assets.iconsText,
              AppLocalizations.of(context)!.importKeysPair,
              () => _importToKeysPair(context)),
          if (Platform.isAndroid || Platform.isIOS)
            buildListTileSvg(
                Assets.iconsScan,
                AppLocalizations.of(context)!.scanQrCode,
                () => DialogRouter.showDialogScanQr(context)),
          if(Responsive.isMobile(context))   ListTile(
              title: Text(AppLocalizations.of(context)!.fileWallet,
                  style: AppTextStyles.dialogTitle)),
          ListTile(
              leading:
                  SvgPicture.asset(Assets.iconsImport, height: 32, width: 32),
              title: Text(AppLocalizations.of(context)!.importFile,
                  style: AppTextStyles.itemStyle
                      .copyWith(fontFamily: "GilroySemiBold")),
              subtitle: Text(AppLocalizations.of(context)!.importFileSubtitle,
                  style: AppTextStyles.itemStyle.copyWith(fontSize: 16)),
              onTap: () => _importWalletFile(context)),
       /*   ListTile(
              leading:
                  SvgPicture.asset(Assets.iconsExport, height: 32, width: 32),
              title: Text(AppLocalizations.of(context)!.exportFile,
                  style: AppTextStyles.itemStyle
                      .copyWith(fontFamily: "GilroySemiBold")),
              subtitle: Text(AppLocalizations.of(context)!.exportFileSubtitle,
                  style: AppTextStyles.itemStyle.copyWith(fontSize: 16)),

        */
            /*  trailing: PopupMenuButton<String>(
                onSelected: (String choice) {
                  if (choice == '.pkw') {
                    _exportWalletFile(context, FormatWalletFile.pkw);
                  } /*else if (choice == '.nososova') {
                    _exportWalletFile(context, FormatWalletFile.nososova);
                  }
                  */
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'pkw',
                      child: Text('.pkw'),
                    ),
                    /*
                   const PopupMenuItem<String>(

                      value: '.nososova',
                      child: Text('.nososova'),


                    ),*/
                  ];
                },
              ),


              onTap: () =>
                  _exportWalletFile(context, FormatWalletFile.nososova)), */
          const SizedBox(height: 10)
        ],
      )),
    ]);
  }

  void _createNewAddress(BuildContext context) async {
    walletBloc.add(CreateNewAddress());
    if(Responsive.isMobile(context))  Navigator.pop(context);
  }

  void _importToKeysPair(BuildContext context) async {
    if(Responsive.isMobile(context))  Navigator.pop(context);
    DialogRouter.showDialogImportAddressFromKeysPair(widget.scaffoldKey?.currentContext ?? context);

  }

  void _importWalletFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      walletBloc.add(ImportWalletFile(result));
      if (!context.mounted) return;
      if(Responsive.isMobile(context))  Navigator.pop(context);
    }
  }

  void _exportWalletFile(
      BuildContext context, FormatWalletFile formatFile) async {
    var nameWallet = '';
    List<String> jsonList = walletBloc.state.wallet.address
        .map((wallet) => jsonEncode(wallet.toJsonExport()))
        .toList();

    if (formatFile == FormatWalletFile.pkw) {
      nameWallet = 'wallet.pkw';
    } else if (formatFile == FormatWalletFile.nososova) {
      if (Platform.isIOS || Platform.isAndroid || Platform.isMacOS) {
        FlutterFileSaverDev().writeFileAsString(
          fileName: 'wallet.nososova',
          data: "llol",
        );
      } else if (Platform.isLinux || Platform.isWindows) {
        String? outputFile = await FilePicker.platform.saveFile(
          dialogTitle: 'Please select an output file:',
          fileName: 'output-file.pdf',
        );
        if (outputFile == null) {
          // User canceled the picker
        }
      }
    }
  }
}
