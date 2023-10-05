import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../database/database.dart';
import '../../l10n/app_localizations.dart';
import '../../models/address_object.dart';
import '../../utils/noso/crypto.dart';
import '../../utils/const/status_qr.dart';
import '../theme/style/colors.dart';
import 'dialog_search_address.dart';
import 'dialog_send_address.dart';

class DialogScanQr {
  void loadDialog({BuildContext? context, required AppDataBloc appDataBloc}) {
    assert(context != null);

    showDialog(
        context: context!,
        builder: (context) => BlocProvider.value(
              value: appDataBloc,
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 400,
                  width: 600,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const ScannerWidget(),
                ),
              ),
            ));
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
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildQrView(context),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: CustomColors.primaryColor,
            ),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
        ],
      );
    });
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((Barcode scanData) async {
      ///це все потрібно перенести в логіку блок
      ///в діалог передавати рядок з кодом
      ///а в тих діалогах вже працювати з блоком

      String data = scanData.code.toString();
      final TypeQrCode qrStatus = CheckQrCode.checkQrScan(data);






      if (qrStatus == TypeQrCode.qrKeys) {
        controller.pauseCamera();
        final AddressObject? address = null;
           // NosoCripto().importWalletForKeys(scanData.code.toString());

        if (address != null) {
          Address addressDB = Address(
              publicKey: address.publicKey.toString(),
              privateKey: address.privateKey.toString(),
              hash: address.hash.toString());
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return DialogSearchAddress(
                addressObject: addressDB,
                onCancelButtonPressed: () {
                  controller.resumeCamera();
                },
                onAddToWalletButtonPressed: () {
                  // _addAddress(addressDB);
                  Navigator.pop(context);
                },
              );
            },
          );
        } else {
          controller.resumeCamera();
        }
      } else if (qrStatus == TypeQrCode.qrAddress) {
        controller.pauseCamera();
        showModalBottomSheet(
            context: context,
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
