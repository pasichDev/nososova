
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildQrView(context),
          ),
       /*   const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Наведіть видошукач на ваш QR Code',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

        */
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
        borderColor: Colors.red,
        borderLength: 32,
        borderWidth: 8,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  String B58Alphabet =
      "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
  String B36Alphabet = "0123456789abcdefghijklmnopqrstuvwxyz";
  String B64Alphabet =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Обробка результатів сканування QR-коду тут
      //    print('Scanned data: ${scanData.code}');
      String token =
          'BGKzxkNqokqvDRIOS/5Ni3ZFBkE8cAcVeWP7zTO3qj/c/lFFCqkU3On202+pot5pzZrkCrlFTAKHFn8wiW7rE2g= 3QsprgNCeHEygw1wCEIRzdUpcCOaNcaVtfjQcKGLN9Y=';

      List<String> tokens = token.split("/c/");
      print('split tokens => + $tokens.length');
      if (tokens.length == 2) {
        String publicKey = tokens[0];
        String privateKey = tokens[1];

        String testSignature =
            mpCripto_getStringSigned("VERIFICATION", privateKey);

        print('next decon');
      }
    });
  }

  String mpCripto_getStringSigned(String stringtoSign, String privatKey) {
    // Uint8List  messageAsBytes = SpecialBase64Decode(stringtoSign);

    /* Uint8List signature = SignerUtils_SignMessage(
        messageAsBytes,
        base64.decode(privatKey),
        KeyType.SECP256K1
    );

    */

    //  return base64.decode(signature).toString();
    return 'test';
  }

// Function to sign a message using DSA with elliptic curve cryptography

/*  Uint8List signMessage(Uint8List message, Uint8List privateKey, KeyType aKeyType) {
    var lCurve = SignerUtils.getCurve(aKeyType);
    var domain = SignerUtils.getDomain(lCurve);
    var lRecreatedPrivKey = ECPrivateKey(privateKey as BigInt?, domain);

    var lSigner = SignerUtils.getSigner();
    lSigner.init(true, PrivateKeyParameter(lRecreatedPrivKey));
    lSigner.update(Uint8List.fromList(message));
    var signature = lSigner.generateSignature();

    return signature.bytes;
  }

  ECDomainParameters getCurve(KeyType aKeyType) {
    switch (aKeyType) {
      case KeyType.SECP256K1:
        return ECCurve_secp256k1();
      case KeyType.SECP384R1:
        return ECCurve_secp384r1();
      case KeyType.SECP521R1:
        return ECCurve_secp521r1();
      case KeyType.SECT283K1:
        return ECCurve_sect283k1();
      default:
        throw ArgumentError('Invalid key type');
    }
  }
  Uint8List  SpecialBase64Decode(String input){
    final indexList = <int>[];

    for (final c in input.codeUnits) {
      indexList.add(B64Alphabet.indexOf(String.fromCharCode(c)));
    }

    var binaryString = '';
    for (final i in indexList) {
      var binary = i.toRadixString(2);
      while (binary.length < 6) binary = '0' + binary;
      binaryString += binary;
    }

    var strAux = binaryString;
    final tempByteArray = <int>[];

    while (strAux.length >= 8) {
      final currentGroup = strAux.substring(0, 8);
      final intVal = int.parse(currentGroup, radix: 2);
      tempByteArray.add(intVal);
      strAux = strAux.substring(8);
    }

    final encodedByteArray = Uint8List.fromList(tempByteArray);

    return encodedByteArray;

  }
















 */
}

class KeyPair {
  late String PublicKey;
  late String PrivateKey;
}

enum KeyType {
  SECP256K1,
  SECP384R1,
  SECP521R1,
  SECT283K1,
}
