import 'package:flutter/foundation.dart';
import 'package:noso_dart/const.dart';
import 'package:noso_dart/core.dart';
import 'package:noso_dart/models/address_object.dart';

final class Noso extends NosoCore {
  /// Returns the generated transfer hash
  String getTransferHash(String value) {
    var hash256 = getSha256HashToString(value);
    hash256 = base58Encode(hash256, BigInt.from(58));
    var sumatoria = base58Checksum(hash256);
    final bd58 = base58DecimalTo58(sumatoria.toString());

    return "tr$hash256$bd58";
  }

  /// Returns the generated order hash
  String getOrderHash(String value) {
    var sha256 = getSha256HashToString(value);
    sha256 = base58Encode(sha256, BigInt.from(36));
    return "OR$sha256";
  }

  /// Generate new address
  AddressObject createNewAddress() {
    KeyPair keysPair = generateKeyPair;
    return AddressObject(
        publicKey: keysPair.publicKey,
        privateKey: keysPair.privateKey,
        hash: getAddressFromPublicKey(keysPair.publicKey));
  }

  /// Import Address from KeysPair
  AddressObject? importAddressForKeysPair(String keys) {
    List<String> keyParts = keys.split(' ');

    if (keyParts.length == 2) {
      String publicKeyPart = keyParts[0];
      String privateKeyPart = keyParts[1];

      bool verification = verifyKeysPair(publicKeyPart, privateKeyPart);
      if (verification &&
          privateKeyPart.length == 44 &&
          publicKeyPart.length == 88) {
        return AddressObject(
            hash: getAddressFromPublicKey(publicKeyPart),
            privateKey: privateKeyPart,
            publicKey: publicKeyPart);
      }
    }
    return null;
  }

  /// A method that checks the secret keys for an address
  bool verifyKeysPair(String publicKey, String privateKey) {
    var signature = signMessage(NosoConst.verifyMessage, privateKey);
    return verifySignedString(NosoConst.verifyMessage, signature, publicKey);
  }

  List<AddressObject> parseExternalWallet(Uint8List? fileBytes) {
    final List<AddressObject> address = [];
    if (fileBytes == null || fileBytes.isEmpty) {
      return address;
    }
    Uint8List current = fileBytes.sublist(0, 625);
    Uint8List bytes = fileBytes.sublist(626);

    while (current.isNotEmpty) {
      AddressObject addressObject = AddressObject(
          hash: String.fromCharCodes(current.sublist(1, current[0] + 1)),
          custom: String.fromCharCodes(current.sublist(42, 42 + current[41])),
          publicKey:
              String.fromCharCodes(current.sublist(83, 83 + current[82])),
          privateKey:
              String.fromCharCodes(current.sublist(339, 339 + current[338])));

      if (bytes.length >= 626) {
        current = bytes.sublist(0, 625);
        bytes = bytes.sublist(626);
      } else {
        current = Uint8List(0);
      }

      if (addressObject.privateKey.length == 44 &&
          addressObject.publicKey.length == 88) {
        bool verification =
            verifyKeysPair(addressObject.publicKey, addressObject.privateKey);
        if (verification) {
          address.add(addressObject);
        }
      }
    }
    return address;
  }
}
