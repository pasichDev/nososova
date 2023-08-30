import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:nososova/const.dart';
import 'package:nososova/database/models/objects.dart';
import 'package:nososova/database/models/wallet_object.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/key_generators/ec_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';

final class NosoCripto {
  WalletObject? createNewAddress() {
    KeyPair keysPair = _generateKeysPair();
    WalletObject walletObject = WalletObject();
    walletObject.publicKey = keysPair.publicKey;
    walletObject.privateKey = keysPair.privateKey;
    walletObject.hash = _getAddressWalletFromPublicKey(keysPair.publicKey);

    return walletObject;
  }

  WalletObject? importWalletForKeys(String keys) {
    List<String> keyParts = keys.split(' ');

    if (keyParts.length == 2) {
      String publicKeyPart = keyParts[0];
      String privateKeyPart = keyParts[1];

      bool verification = true;

      if (verification &&
          privateKeyPart.length == 44 &&
          publicKeyPart.length == 88) {
        WalletObject walletObject = WalletObject();
        walletObject.publicKey = publicKeyPart;
        walletObject.privateKey = privateKeyPart;
        walletObject.hash = _getAddressWalletFromPublicKey(publicKeyPart);

        return walletObject;
      }
    }
    return null;
  }

  String _getAddressWalletFromPublicKey(String publicKey) {
    final pubSHAHashed = _getHashSha256ToString(publicKey);
    final hash1 = _getHashMD160ToString(pubSHAHashed);
    final hash1Encoded = _bmHexTo58(hash1, BigInt.from(58));
    final sumatoria = _bmB58Resumen(hash1Encoded);
    final clave = _bmDecTo58(sumatoria.toString());
    final hash2 = hash1Encoded + clave;
    return Const.coinChar + hash2;
  }

  String _getHashSha256ToString(String publicKey) {
    final sha256 = SHA256Digest();
    final bytes = utf8.encode(publicKey);
    final digest = sha256.process(Uint8List.fromList(bytes));

    final result = hex.encode(digest);

    return result.replaceAll('-', '').toUpperCase();
  }

  String _getHashMD160ToString(String hash256) {
    final hash = RIPEMD160Digest();
    final bytes = Uint8List.fromList(hash256.codeUnits);
    final hashResult = hash.process(bytes);

    final hashHex = hex.encode(hashResult);

    return hashHex.toUpperCase();
  }

  String _bmHexTo58(String numerohex, BigInt alphabetnumber) {
    BigInt decimalValue = _bmHexToDec(numerohex);
    String result = '';
    String alphabetUsed;

    if (alphabetnumber == BigInt.from(36)) {
      alphabetUsed = Const.b36Alphabet;
    } else {
      alphabetUsed = Const.b58Alphabet;
    }

    while (decimalValue.bitLength >= 2) {
      DivResult resultadoDiv = _divideBigInt(decimalValue, alphabetnumber);
      decimalValue = resultadoDiv.coefficient;
      int restante = resultadoDiv.remainder.toInt();
      result = alphabetUsed[restante] + result;
    }

    if (decimalValue >= alphabetnumber) {
      DivResult resultadoDiv = _divideBigInt(decimalValue, alphabetnumber);
      decimalValue = resultadoDiv.coefficient;
      int restante = resultadoDiv.remainder.toInt();
      result = alphabetUsed[restante] + result;
    }

    if (decimalValue > BigInt.zero) {
      int value = decimalValue.toInt();
      result = alphabetUsed[value] + result;
    }

    return result;
  }

  int _bmB58Resumen(String input) {
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

  String _bmDecTo58(String number) {
    var decimalValue = BigInt.parse(number);
    DivResult resultDiv;
    String remaining;
    String result = '';

    while (decimalValue.bitLength >= 2) {
      resultDiv = _divideBigInt(decimalValue, BigInt.from(58));
      decimalValue = resultDiv.coefficient;
      remaining = resultDiv.remainder.toInt().toString();
      result = Const.b58Alphabet[int.parse(remaining)] + result;
    }

    if (decimalValue >= BigInt.from(58)) {
      resultDiv = _divideBigInt(decimalValue, BigInt.from(58));
      decimalValue = resultDiv.coefficient;
      remaining = resultDiv.remainder.toInt().toString();
      result = Const.b58Alphabet[int.parse(remaining)] + result;
    }

    if (decimalValue > BigInt.zero) {
      result = Const.b58Alphabet[decimalValue.toInt()] + result;
    }

    return result;
  }

  BigInt _bmHexToDec(String numerohex) {
    final bytes = <int>[];
    for (var i = 0; i < numerohex.length; i += 2) {
      final byteString = numerohex.substring(i, i + 2);
      final byte = int.parse(byteString, radix: 16);
      bytes.add(byte);
    }
    final hexString =
        bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    return BigInt.parse(hexString, radix: 16);
  }

  KeyPair _generateKeysPair() {
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
}
