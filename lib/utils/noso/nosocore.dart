import 'dart:math';
import 'dart:typed_data';

import 'package:nososova/utils/noso/src/crypto.dart';

import '../../database/database.dart';
import '../../models/node.dart';
import '../../models/pending_transaction.dart';
import '../../models/seed.dart';
import '../const/const.dart';
import 'src/address_object.dart';

final class NosoCore extends NosoCrypto {
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

      bool verification =
          verifyKeysPair(Const.verifyMessage, publicKeyPart, privateKeyPart);
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

  bool verifyKeysPair(String message, String publicKey, String privateKey) {
    var signerMessage = signMessage(message, privateKey);
    return verifySignedString(message, signerMessage, publicKey);
  }

  List<Address> parseExternalWallet(Uint8List? fileBytes) {
    final List<Address> address = [];
    if (fileBytes == null) {
      return address;
    }
    Uint8List current = fileBytes.sublist(0, 625);
    Uint8List bytes = fileBytes.sublist(626);

    while (current.isNotEmpty) {
      Address addressObject = Address(
          hash: String.fromCharCodes(current.sublist(1, current[0] + 1)),
          // custom: String.fromCharCodes(current.sublist(42, 42 + current[41])),
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

      bool verification = verifyKeysPair(Const.verifyMessage,
          addressObject.publicKey, addressObject.privateKey);
      if (verification &&
          addressObject.privateKey.length == 44 &&
          addressObject.publicKey.length == 88) {
        address.add(addressObject);
      }
    }
    return address;
  }

  String parseMNString(List<int>? response) {
    final resultMNList = <Seed>[];
    final StringBuffer parsedData = StringBuffer();

    if (response == null) {
      return "";
    }
    final tokens = String.fromCharCodes(response).split(' ');
    if (tokens.length > 1) {
      tokens.skip(1);

      for (final rawNodeInfo in tokens) {
        final sanitizedNodeInfo =
            rawNodeInfo.replaceAll(':', ' ').replaceAll(';', ' ');
        final nodeValues = sanitizedNodeInfo.split(' ');

        if (nodeValues.length >= 4) {
          final nodeInfo = Seed()
            ..ip = nodeValues[0]
            ..port = int.tryParse(nodeValues[1])!;

          resultMNList.add(nodeInfo);
          parsedData.write('${nodeInfo.ip}:${nodeInfo.port}|');
        }
      }
    }

    return parsedData.toString();
  }

  Node parseResponseNode(List<int>? response, Seed seedActive) {
    if (response == null) {
      return Node(seed: seedActive);
    }
    List<String> values = String.fromCharCodes(response).split(" ");

    return Node(
      seed: seedActive,
      connections: int.tryParse(values[1]) ?? 0,
      lastblock: int.tryParse(values[2]) ?? 0,
      pendings: int.tryParse(values[3]) ?? 0,
      delta: int.tryParse(values[4]) ?? 0,
      branch: values[5],
      version: values[6],
      utcTime: int.tryParse(values[7]) ?? 0,
    );
  }

  List<PendingTransaction> parsePendings(List<int>? response) {
    if (response == null) {
      return [];
    }
    List<String> array = String.fromCharCodes(response).split("\n");
    List<PendingTransaction> pendingList = [];
    for (String value in array) {
      var pending = value.split(",");
      pendingList.add(PendingTransaction(
          orderType: pending[0],
          address: pending[1],
          receiver: pending[2],
          amountTransfer: pending[3],
          amountFee: pending[4]));
    }
    return pendingList;
  }

  String getRandomNode(String? inputString) {
    if (inputString == null) {
      return "127.0.0.1:8080";
    }

    List<String> elements = inputString.split('|');
    int elementCount = elements.length;

    if (elementCount > 0) {
      int randomIndex = Random().nextInt(elementCount);

      return elements[randomIndex];
    } else {
      return "127.0.0.1:8080";
    }
  }
}
