import 'package:flutter/material.dart';
import 'package:nososova/database/models/address_object.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/components/decoration/standart_gradient_decoration.dart';
import 'package:nososova/utils/noso/cripto.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  QRScanScreenState createState() => QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
    } else {
      Navigator.pop(context);
      dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.titleScannerCode),
          backgroundColor: Colors.transparent,
          flexibleSpace:
              Container(decoration: const StandartGradientDecoration(borderRadius: null))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildQrView(context),
          ),

    Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.descriptionScannerCode,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 16,
        borderColor: Colors.blue,
        borderLength: 32,
        borderWidth: 8,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      NosoCripto cripto = NosoCripto();

      AddressObject? wallets =
          cripto.importWalletForKeys(scanData.code.toString());

      print('hash ${wallets?.hash}');
      print('privateKey ${wallets?.privateKey}');
      print('publicKey ${wallets?.publicKey}');
      Navigator.pop(context);
      dispose();
    });
  }
}
