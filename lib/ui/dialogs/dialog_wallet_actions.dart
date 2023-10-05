import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';

import '../../blocs/events/wallet_events.dart';
import '../../utils/const/files_const.dart';
import '../../utils/file_utils.dart';
import '../../utils/noso/parse.dart';
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
          ListTile(
              title: Text(AppLocalizations.of(context)!.newTitle,
                  style: AppTextStyles.dialogTitle)),
          buildListTile(Icons.add, AppLocalizations.of(context)!.genNewKeyPair,
              () => _createNewAddress(context)),
          ListTile(
              title: Text(AppLocalizations.of(context)!.import,
                  style: AppTextStyles.dialogTitle)),
          if (Platform.isAndroid || Platform.isIOS)
            buildListTile(Icons.qr_code,
                AppLocalizations.of(context)!.scanQrCode, () => {}),
          buildListTile(
              Icons.file_copy_outlined,
              AppLocalizations.of(context)!.selectFilePkw,
              () => _importWalletFile(context)),
          ListTile(
              title: Text(AppLocalizations.of(context)!.export,
                  style: AppTextStyles.dialogTitle)),
          buildListTile(
              Icons.file_copy_outlined,
              AppLocalizations.of(context)!.saveFilePkw,
              () => _exportWalletFile(context)),
          const SizedBox(height: 10)
        ],
      ),
    ]);
  }

  void _createNewAddress(BuildContext context) async {
    walletBloc.add(CreateNewAddress());
    Navigator.pop(context);
  }

  void _exportWalletFile(BuildContext context) async {}

  // TODO Перенести деякі операції при роботі з файлом інший класс (наприклад перевірка розширення)
  void _importWalletFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (!context.mounted) return;
    if (result != null) {
      var file = result.files.first;
      if (file.extension?.toLowerCase() == FilesConst.pkwExtensions) {
        var bytes = await FileUtils.readBytesFromPlatformFile(file);
        var listAddress = NosoParse.parseExternalWallet(bytes);

        if (listAddress.isNotEmpty) {
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Це файл не має записаних адрес'),
              elevation: 6.0,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Цей файл не підтримується",
              style: TextStyle(fontSize: 16.0, color: Colors.white)),
          backgroundColor: Colors.red,
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
        ));
      }
    }

    if (!context.mounted) return;
    Navigator.pop(context);
  }
}
