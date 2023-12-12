import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../blocs/events/wallet_events.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/const/status_qr.dart';
import '../../theme/style/colors.dart';
import '../../theme/style/dialog_style.dart';
import '../dialog_send_address.dart';

class DialogScannerQr {
  void showDialogScanQr(BuildContext context, WalletBloc walletBloc) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          BlocProvider.value(value: walletBloc, child: const ScannerWidget()),
    );
  }
}

class ScannerWidget extends StatefulWidget {
  const ScannerWidget({super.key});

  @override
  ScannerWidgetState createState() => ScannerWidgetState();
}

class ScannerWidgetState extends State<ScannerWidget> {
  QRViewController? controller;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QrNoso');
  bool isScanned = false;
  late WalletBloc walletBloc;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ClipRRect(
            child: _buildQrView(context),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.negativeBalance,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style:
                      AppTextStyles.walletAddress.copyWith(color: Colors.white),
                )),
          ),
        )
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    double smallestDimension = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    smallestDimension = min(smallestDimension, 550);

    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        _onQRViewCreated(controller);
      },
      overlay: QrScannerOverlayShape(
          borderColor: Colors.black,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: smallestDimension - 140),
    );
  }


  /// TODO Закінчит работу над сканером
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((Barcode scanData) async {
      String data = scanData.code.toString();
      final TypeQrCode qrStatus = CheckQrCode.checkQrScan(data);

      if (qrStatus == TypeQrCode.qrKeys) {
        controller.pauseCamera();
        walletBloc.add(ImportWalletQr(data));
        Navigator.pop(context);
      } else if (qrStatus == TypeQrCode.qrAddress) {
        controller.pauseCamera();
        Navigator.pop(context);
        controller.pauseCamera();
        showModalBottomSheet(
            context: context,
            shape: DialogStyle.borderShape,
            builder: (BuildContext context) {
              return DialogSendAddress(
                addressTo: data,
                onCancelButtonPressedSend: () {
                  controller.resumeCamera();
                },
                onSendButtonPressed: () {
                  Navigator.pop(context);
                },
              );
            });
      }
    });
  }
}
