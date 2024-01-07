import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:noso_dart/const.dart';
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

class NosoCore {
  final algorithmName = Mac("SHA-1/HMAC");

  /// Generates a key pair containing a private key and a public key.
  KeyPair get generateKeyPair => _generateKeyPair();

  /// Derives an address from a public key.
  String getAddressFromPublicKey(String publicKey) {
    return _getAddressFromPublicKey(publicKey);
  }

  /// Signs a message using a private key and returns the EC signature.
  /// Reference: https://stackoverflow.com/questions/72641616/how-to-convert-asymmetrickeypair-to-base64-encoding-string-in-dart
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

  /// Encodes an EC signature to a Base64-encoded string.
  String encodeSignatureToBase64(ECSignature ecSignature) {
    final encoded = ASN1Sequence(elements: [
      ASN1Integer(ecSignature.r),
      ASN1Integer(ecSignature.s),
    ]).encode();
    return base64Encode(encoded);
  }

  /// Verifies a signed string using the provided EC signature and public key.
  bool verifySignedString(
      String message, ECSignature signature, String publicKey) {
    final Uint8List messageBytes =
        Uint8List.fromList(_nosoBase64Decode(message));
    final ECDomainParameters domain = ECCurve_secp256k1();
    ECPoint? publicKeyPoint =
        domain.curve.decodePoint(base64.decode(publicKey));
    ECPublicKey publicKeys = ECPublicKey(publicKeyPoint, domain);

    var verifier = ECDSASigner(SHA1Digest(), algorithmName)
      ..init(false, PublicKeyParameter<ECPublicKey>(publicKeys));

    return verifier.verifySignature(messageBytes, signature);
  }

  /// Converts a byte array to a BigInt
  BigInt bytesToBigInt(Uint8List bytes) {
    BigInt result = BigInt.zero;
    for (int i = 0; i < bytes.length; i++) {
      result = (result << 8) + BigInt.from(bytes[i]);
    }
    return result;
  }

  /// Derives an address from a public key using multiple hashing algorithms.
  String _getAddressFromPublicKey(String publicKey) {
    final pubSHAHashed = getSha256HashToString(publicKey);
    final hash1 = _getMd160HashToString(pubSHAHashed);
    final hash1Encoded = base58Encode(hash1, BigInt.from(58));
    final sum = base58Checksum(hash1Encoded);
    final key = base58DecimalTo58(sum.toString());
    final hash2 = hash1Encoded + key;
    return NosoConst.coinChar + hash2;
  }

  /// Calculates the SHA-256 hash of a given public key.
  String getSha256HashToString(String publicKey) {
    final sha256 = SHA256Digest();
    final bytes = utf8.encode(publicKey);
    final digest = sha256.process(Uint8List.fromList(bytes));
    final result = hex.encode(digest);
    return result.replaceAll('-', '').toUpperCase();
  }

  /// Calculates the RIPEMD-160 hash of a given SHA-256 hash.
  String _getMd160HashToString(String hash256) {
    final hash = RIPEMD160Digest();
    final bytes = Uint8List.fromList(hash256.codeUnits);
    final hashResult = hash.process(bytes);
    final hashHex = hex.encode(hashResult);
    return hashHex.toUpperCase();
  }

  /// Base58 encodes a hexadecimal number using the specified alphabet.
  String base58Encode(String hexNumber, BigInt alphabetNumber) {
    BigInt decimalValue = _hexToDecimal(hexNumber);
    String result = '';
    String alphabetUsed;

    if (alphabetNumber == BigInt.from(36)) {
      alphabetUsed = NosoConst.b36Alphabet;
    } else {
      alphabetUsed = NosoConst.b58Alphabet;
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

  /// Computes the checksum of a Base58-encoded string.
  int base58Checksum(String input) {
    int total = 0;
    for (var i = 0; i < input.length; i++) {
      var currentChar = input[i];
      var foundIndex = NosoConst.b58Alphabet.indexOf(currentChar);
      if (foundIndex != -1) {
        total += foundIndex;
      }
    }
    return total;
  }

  /// Converts a decimal number to Base58 using the specified alphabet.
  String base58DecimalTo58(String number) {
    var decimalValue = BigInt.parse(number);
    DivResult resultDiv;
    String remainder;
    String result = '';

    while (decimalValue.bitLength >= 2) {
      resultDiv = _divideBigInt(decimalValue, BigInt.from(58));
      decimalValue = resultDiv.coefficient;
      remainder = resultDiv.remainder.toInt().toString();
      result = NosoConst.b58Alphabet[int.parse(remainder)] + result;
    }

    if (decimalValue >= BigInt.from(58)) {
      resultDiv = _divideBigInt(decimalValue, BigInt.from(58));
      decimalValue = resultDiv.coefficient;
      remainder = resultDiv.remainder.toInt().toString();
      result = NosoConst.b58Alphabet[int.parse(remainder)] + result;
    }

    if (decimalValue > BigInt.zero) {
      result = NosoConst.b58Alphabet[decimalValue.toInt()] + result;
    }

    return result;
  }

  /// Converts a hexadecimal number to a BigInt.
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

  /// Generates a random key pair.
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

  /// Divides a BigInt by another BigInt and returns the quotient and remainder.
  DivResult _divideBigInt(BigInt numerator, BigInt denominator) {
    DivResult result = DivResult();
    result.coefficient = numerator ~/ denominator;
    result.remainder = numerator % denominator;
    return result;
  }

  /// Decodes a Base64-like encoding used in the NosoCrypto class.
  List<int> _nosoBase64Decode(String input) {
    final indexList = <int>[];
    for (var c in input.codeUnits) {
      final it = NosoConst.b64Alphabet.indexOf(String.fromCharCode(c));
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
