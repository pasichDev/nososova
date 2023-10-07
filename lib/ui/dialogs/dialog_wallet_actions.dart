import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';

import '../../blocs/events/wallet_events.dart';
import '../../utils/const/files_const.dart';
import '../theme/style/text_style.dart';

class DialogWalletActions extends StatelessWidget {
  final WalletBloc walletBloc;

  const DialogWalletActions({required this.walletBloc, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListView(
        shrinkWrap: true,
        children: [
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
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .newFormatWalletFileDescrypt,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const TextSpan(
                          text: " .nososova",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          buildListTile(Icons.add, AppLocalizations.of(context)!.genNewKeyPair,
              () => _createNewAddress(context)),
          if (Platform.isAndroid || Platform.isIOS)
            buildListTile(Icons.qr_code,
                AppLocalizations.of(context)!.scanQrCode, () => {}),
          ListTile(
              title: Text(AppLocalizations.of(context)!.fileWallet,
                  style: AppTextStyles.dialogTitle)),
          ListTile(
              leading: const Icon(Icons.file_copy_outlined),
              title: Text(AppLocalizations.of(context)!.importFile),
              subtitle: Text(AppLocalizations.of(context)!.importFileSubtitle),
              onTap: () => _importWalletFile(context)),
          ListTile(
              leading: const Icon(Icons.file_copy_outlined),
              title: Text(AppLocalizations.of(context)!.exportFile),
              subtitle: Text(AppLocalizations.of(context)!.exportFileSubtitle),
              trailing: PopupMenuButton<String>(
                onSelected: (String choice) {
                  if (choice == '.pkw') {
                    _exportWalletFile(context, FormatWalletFile.pkw);
                  } else if (choice == '.nososova') {
                    _exportWalletFile(context, FormatWalletFile.nososova);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'pkw',
                      child: Text('.pkw'),
                    ),
                    const PopupMenuItem<String>(
                      value: '.nososova',
                      child: Text('.nososova'),
                    ),
                  ];
                },
              ),
              onTap: () =>
                  _exportWalletFile(context, FormatWalletFile.nososova)),
          const SizedBox(height: 10)
        ],
      ),
    ]);
  }

  void _createNewAddress(BuildContext context) async {
    walletBloc.add(CreateNewAddress());
    Navigator.pop(context);
  }

  void _importWalletFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      walletBloc.add(ImportWalletFile(result));
      if (!context.mounted) return;
      Navigator.pop(context);
    }
  }

  void _exportWalletFile(
      BuildContext context, FormatWalletFile formatFile) async {}
}
