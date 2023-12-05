import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:nososova/utils/const/const.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

class KeyPair {
  late String publicKey;
  late String privateKey;
}

class DivResult {
  BigInt coefficient = BigInt.zero;
  BigInt remainder = BigInt.zero;
}

class NosoCrypto {
  final algorithmName = Mac("SHA-1/HMAC");

  /// Public Methods
  KeyPair get generateKeyPair => _generateKeyPair();

  String getAddressFromPublicKey(String publicKey) {
    return _getAddressFromPublicKey(publicKey);
  }

  ///https://stackoverflow.com/questions/72641616/how-to-convert-asymmetrickeypair-to-base64-encoding-string-in-dart
  ECSignature signMessage(String message, String privateKeyBase64) {
    Uint8List messageBytes = Uint8List.fromList(_nosoBase64Decode(message));
    BigInt privateKeyDecode =
        bytesToBigInt(Uint8List.fromList(base64.decode(privateKeyBase64)));
    ECPrivateKey privateKey =
        ECPrivateKey(privateKeyDecode, ECCurve_secp256k1());

    var signer = ECDSASigner(SHA1Digest(), algorithmName)
      ..init(true, PrivateKeyParameter<ECPrivateKey>(privateKey));
    ECSignature ecSignature =
        signer.generateSignature(messageBytes) as ECSignature;

    return ecSignature;
  }

  String encodeSignatureToBase64(ECSignature ecSignature) {
    final encoded = ASN1Sequence(elements: [
      ASN1Integer(ecSignature.r),
      ASN1Integer(ecSignature.s),
    ]).encode();
    return base64Encode(encoded);
  }


  String getTransferHash(String value) {

    var resultado = _getSha256HashToString(value);
    resultado = _base58Encode(resultado, BigInt.from(58));
    var sumatoria = _base58Checksum(resultado);
    final dect = _base58DecimalTo58(sumatoria.toString());

    return "tr$resultado$dect";

  }

  String getOrderHash(String value) {

    var resultado = _getSha256HashToString(value);
    resultado = _base58Encode(resultado, BigInt.from(36));
    return "OR${resultado}";

  }
/*
  fun getOrderHash(textLine:String):String {
  var Result = mpCripto.HashSha256String(textLine)
  return "OR"+ mpCripto.BMHexto58(Result, BigInteger("36"))
  }

 */

  bool verifySignedString(
      String message, ECSignature signature, String publicKey) {
    final Uint8List messageBytes =
        Uint8List.fromList(_nosoBase64Decode(message));
    final ECDomainParameters domain = ECCurve_secp256k1();
    ECPoint? publicKeyPoint =
        domain.curve.decodePoint(base64.decode(publicKey));
    ECPublicKey publicKeys = ECPublicKey(publicKeyPoint, domain);

    var verifier = ECDSASigner(null, algorithmName)
      ..init(false, PublicKeyParameter<ECPublicKey>(publicKeys));

    return verifier.verifySignature(messageBytes, signature);
  }

  BigInt bytesToBigInt(Uint8List bytes) {
    BigInt result = BigInt.zero;
    for (int i = 0; i < bytes.length; i++) {
      result = (result << 8) + BigInt.from(bytes[i]);
    }
    return result;
  }

  String _getAddressFromPublicKey(String publicKey) {
    final pubSHAHashed = _getSha256HashToString(publicKey);
    final hash1 = _getMd160HashToString(pubSHAHashed);
    final hash1Encoded = _base58Encode(hash1, BigInt.from(58));
    final sum = _base58Checksum(hash1Encoded);
    final key = _base58DecimalTo58(sum.toString());
    final hash2 = hash1Encoded + key;
    return Const.coinChar + hash2;
  }

  String _getSha256HashToString(String publicKey) {
    final sha256 = SHA256Digest();
    final bytes = utf8.encode(publicKey);
    final digest = sha256.process(Uint8List.fromList(bytes));
    final result = hex.encode(digest);
    return result.replaceAll('-', '').toUpperCase();
  }

  String _getMd160HashToString(String hash256) {
    final hash = RIPEMD160Digest();
    final bytes = Uint8List.fromList(hash256.codeUnits);
    final hashResult = hash.process(bytes);
    final hashHex = hex.encode(hashResult);
    return hashHex.toUpperCase();
  }

  String _base58Encode(String hexNumber, BigInt alphabetNumber) {
    BigInt decimalValue = _hexToDecimal(hexNumber);
    String result = '';
    String alphabetUsed;

    if (alphabetNumber == BigInt.from(36)) {
      alphabetUsed = Const.b36Alphabet;
    } else {
      alphabetUsed = Const.b58Alphabet;
    }

    while (decimalValue.bitLength >= 2) {
      DivResult divResult = _divideBigInt(decimalValue, alphabetNumber);
      decimalValue = divResult.coefficient;
      int remainder = divResult.remainder.toInt();
      result = alphabetUsed[remainder] + result;
    }

    if (decimalValue >= alphabetNumber) {
      DivResult divResult = _divideBigInt(decimalValue, alphabetNumber);
      decimalValue = divResult.coefficient;
      int remainder = divResult.remainder.toInt();
      result = alphabetUsed[remainder] + result;
    }

    if (decimalValue > BigInt.zero) {
      int value = decimalValue.toInt();
      result = alphabetUsed[value] + result;
    }

    return result;
  }

  int _base58Checksum(String input) {
    int total = 0;
    for (var i = 0; i < input.length; i++) {
      var currentChar = input[i];
      var foundIndex = Const.b58Alphabet.indexOf(currentChar);
      if (foundIndex != -1) {
        total += foundIndex;
      }
    }
    return total;
  }

  String _base58DecimalTo58(String number) {
    var decimalValue = BigInt.parse(number);
    DivResult resultDiv;
    String remainder;
    String result = '';

    while (decimalValue.bitLength >= 2) {
      resultDiv = _divideBigInt(decimalValue, BigInt.from(58));
      decimalValue = resultDiv.coefficient;
      remainder = resultDiv.remainder.toInt().toString();
      result = Const.b58Alphabet[int.parse(remainder)] + result;
    }

    if (decimalValue >= BigInt.from(58)) {
      resultDiv = _divideBigInt(decimalValue, BigInt.from(58));
      decimalValue = resultDiv.coefficient;
      remainder = resultDiv.remainder.toInt().toString();
      result = Const.b58Alphabet[int.parse(remainder)] + result;
    }

    if (decimalValue > BigInt.zero) {
      result = Const.b58Alphabet[decimalValue.toInt()] + result;
    }

    return result;
  }

  BigInt _hexToDecimal(String hexNumber) {
    final bytes = <int>[];
    for (var i = 0; i < hexNumber.length; i += 2) {
      final byteString = hexNumber.substring(i, i + 2);
      final byte = int.parse(byteString, radix: 16);
      bytes.add(byte);
    }
    final hexString =
        bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    return BigInt.parse(hexString, radix: 16);
  }

  KeyPair _generateKeyPair() {
    final secureRandom = FortunaRandom()
      ..seed(KeyParameter(Uint8List.fromList(
          List.generate(32, (_) => Random.secure().nextInt(256)))));

    final curve = ECCurve_secp256k1();
    final domainParams = ECKeyGeneratorParameters(curve);

    final keyGenerator = ECKeyGenerator()
      ..init(ParametersWithRandom(domainParams, secureRandom));

    final keyPair = keyGenerator.generateKeyPair();

    final privateKey = keyPair.privateKey as ECPrivateKey;
    final publicKey = keyPair.publicKey as ECPublicKey;

    final privateKeyBytes =
        privateKey.d!.toRadixString(16).toUpperCase().padLeft(64, '0');
    final publicKeyBytes = publicKey.Q!.getEncoded(false);

    final KeyPair keys = KeyPair();
    keys.privateKey = base64.encode(hex.decode(privateKeyBytes));
    keys.publicKey = base64.encode(publicKeyBytes);

    return keys;
  }

  DivResult _divideBigInt(BigInt numerator, BigInt denominator) {
    DivResult result = DivResult();
    result.coefficient = numerator ~/ denominator;
    result.remainder = numerator % denominator;
    return result;
  }

  List<int> _nosoBase64Decode(String input) {
    final indexList = <int>[];
    for (var c in input.codeUnits) {
      final it = Const.b64Alphabet.indexOf(String.fromCharCode(c));
      if (it != -1) {
        indexList.add(it);
      }
    }

    final binaryString =
        indexList.map((i) => i.toRadixString(2).padLeft(6, '0')).join();

    var strAux = binaryString;
    final tempByteArray = <int>[];

    while (strAux.length >= 8) {
      final currentGroup = strAux.substring(0, 8);
      final intVal = int.parse(currentGroup, radix: 2);
      tempByteArray.add(intVal);
      strAux = strAux.substring(8);
    }

    return tempByteArray;
  }
}
