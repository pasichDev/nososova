import 'dart:math';
import 'dart:typed_data';

import 'package:nososova/utils/noso/model/summary_data.dart';
import 'package:nososova/utils/noso/src/crypto.dart';

import '../../models/app/parse_mn_info.dart';
import '../../models/seed.dart';
import '../const/const.dart';
import 'model/address_object.dart';
import 'model/node.dart';
import 'model/pending_transaction.dart';

final class NosoCore extends NosoCrypto {
  ///delete
  /*  String createAliasOrder(Address targetAddress, int block, String alias) {
     final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
     const int amount = 0;
     const int fre = Const.customizationFee;
     const int trxLine = 1;
     const String type = "CUSTOM";
     var message = (currentTimeMillis.toString() +
         targetAddress.hash +
         alias +
         amount.toString() +
         fre.toString() +
         trxLine.toString());

     var signature = NosoCrypto().signMessage('Customize this ${targetAddress.nameAddressFull} $alias', targetAddress.privateKey);

     NewOrderSend orderInfo = NewOrderSend(
         orderID: '',
         orderLines: trxLine,
         orderType: type,
         timeStamp: currentTimeMillis,
         reference: 'null',
         trxLine: trxLine,
         sender: targetAddress.publicKey,
         address: targetAddress.nameAddressFull,
         receiver: alias,
         amountFee: fre,
         amountTrf: amount,
         signature: NosoCrypto().encodeSignatureToBase64(signature),
         trfrID: NosoCore().getTransferHash(currentTimeMillis.toString() +
             targetAddress.nameAddressFull +
             alias// +
           //amount.toString() +
           //  block.toString()
         ));

     orderInfo.orderID = NosoCore().getOrderHash(
         "$trxLine${currentTimeMillis.toString() + (orderInfo.trfrID ?? "")}");

     var orderStringCustom =
         "NS$type ${Const.protocol} ${Const.programVersion} ${DateTime.now().millisecondsSinceEpoch ~/ 1000} ORDER $trxLine \$${orderInfo.getStringToData()} \$";

     return orderStringCustom.substring(0, orderStringCustom.length - 2);

  }

  */

  /*
   final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const int amount = 0;
    const int fre = Const.customizationFee;
    const int trxLine = 1;
    const String type = "CUSTOM";
    var message = (currentTimeMillis.toString() +
        targetAddress.hash +
        alias +
        amount.toString() +
        fre.toString() +
        trxLine.toString());

    var signature = NosoCrypto().signMessage('Customize this ${targetAddress.nameAddressFull} $alias', targetAddress.privateKey);

    NewOrderData orderInfo = NewOrderData(
        orderID: '',
        orderLines: trxLine,
        orderType: type,
        timeStamp: currentTimeMillis,
        reference: 'null',
        trxLine: trxLine,
        sender: targetAddress.publicKey,
        address: targetAddress.nameAddressFull,
        receiver: alias,
        amountFee: fre,
        amountTrf: amount,
        signature: NosoCrypto().encodeSignatureToBase64(signature),
        trfrID: NosoCore().getTransferHash(currentTimeMillis.toString() +
            targetAddress.nameAddressFull +
            alias// +
            //amount.toString() +
          //  block.toString()
        ));

    orderInfo.orderID = NosoCore().getOrderHash(
        "$trxLine${currentTimeMillis.toString() + orderInfo.trfrID}");

    var orderStringCustom =
        "NS$type ${Const.protocol} ${Const.programVersion} ${DateTime.now().millisecondsSinceEpoch ~/ 1000} ORDER $trxLine \$${orderInfo.getStringFromOrder()} \$";

    return orderStringCustom.substring(0, orderStringCustom.length - 2);

   */

  String getTransferHash(String value) {
    var hash256 = getSha256HashToString(value);
    hash256 = base58Encode(hash256, BigInt.from(58));
    var sumatoria = base58Checksum(hash256);
    final bd58 = base58DecimalTo58(sumatoria.toString());

    return "tr$hash256$bd58";
  }

  String getOrderHash(String value) {
    var sha256 = getSha256HashToString(value);
    sha256 = base58Encode(sha256, BigInt.from(36));
    return "OR$sha256";
  }

  /// Generate new address
  Address createNewAddress() {
    KeyPair keysPair = generateKeyPair;
    return Address(
        publicKey: keysPair.publicKey,
        privateKey: keysPair.privateKey,
        hash: getAddressFromPublicKey(keysPair.publicKey));
  }

  /// Import Address from KeysPair
  Address? importAddressForKeysPair(String keys) {
    List<String> keyParts = keys.split(' ');

    if (keyParts.length == 2) {
      String publicKeyPart = keyParts[0];
      String privateKeyPart = keyParts[1];

      bool verification = verifyKeysPair(publicKeyPart, privateKeyPart);

      print(verification);
      if (verification &&
          privateKeyPart.length == 44 &&
          publicKeyPart.length == 88) {
        return Address(
            hash: getAddressFromPublicKey(publicKeyPart),
            privateKey: privateKeyPart,
            publicKey: publicKeyPart);
      }
    }
    return null;
  }

  bool verifyKeysPair(String publicKey, String privateKey) {
    var signature = signMessage(Const.verifyMessage, privateKey);
    return verifySignedString(Const.verifyMessage, signature, publicKey);
  }

  List<Address> parseExternalWallet(Uint8List? fileBytes) {
    final List<Address> address = [];
    if (fileBytes == null || fileBytes.isEmpty) {
      return address;
    }
    Uint8List current = fileBytes.sublist(0, 625);
    Uint8List bytes = fileBytes.sublist(626);

    while (current.isNotEmpty) {
      Address addressObject = Address(
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

  ParseMNInfo parseMNString(List<int>? response) {
    final resultMNList = <Seed>[];
    final StringBuffer parsedData = StringBuffer();

    if (response == null) {
      return ParseMNInfo();
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
            ..port = int.tryParse(nodeValues[1])!
            ..address = nodeValues[2];

          resultMNList.add(nodeInfo);
          parsedData.write('${nodeInfo.ip}:${nodeInfo.port}|');
        }
      }
    }

    return ParseMNInfo(
        count: resultMNList.length,
        nodes: parsedData.toString(),
        listNodes: resultMNList);
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
    if (response == null || response.isEmpty) {
      return [];
    }
    List<String> array = String.fromCharCodes(response).split(" ");
    List<PendingTransaction> pendingList = [];

    for (String value in array) {
      var pending = value.split(",");
      if (pending.length >= 5) {
        pendingList.add(PendingTransaction(
          orderType: pending[0],
          sender: pending[1],
          receiver: pending[2],
          amountTransfer: int.parse(pending[3]) / 100000000,
          amountFee: int.parse(pending[4]) / 100000000,
        ));
      }
    }
    return pendingList;
  }

  List<SumaryData> parseSumary(Uint8List bytes) {
    if (bytes.isEmpty) {
      return [];
    }
    final List<SumaryData> addressSummary = [];
    int index = 0;

    while (index + 106 <= bytes.length) {
      final sumData = SumaryData();

      sumData.hash = String.fromCharCodes(
          bytes.sublist(index + 1, index + bytes[index] + 1));
      sumData.custom = String.fromCharCodes(
          bytes.sublist(index + 42, index + 42 + bytes[index + 41]));
      sumData.balance =
          _bigEndianToDouble(bytes.sublist(index + 82, index + 90));

      final scoreArray = bytes.sublist(index + 91, index + 98);
      if (!scoreArray.every((element) => element == 0)) {
        sumData.score = _bigEndianToInt(scoreArray);
      }

      addressSummary.add(sumData);
      index += 106;
    }
    return addressSummary;
  }

  int doubleToBigEndian(double value) {
    var byteData = ByteData(8);
    byteData.setFloat64(
        0, value, Endian.little); // Встановлюємо значення в little-endian

    //  var byteBuffer = Uint8List.fromList(Uint8List).buffer;
    //  var dataView = ByteData.view(byteBuffer);
    var intValue = byteData.setFloat64(0, value, Endian.little);

    //  print(intValue);
    //  print(String.fromCharCodes());
    //  Int64 int64Value = Int64.fromBytes(result);
    return 99;
    //  return byteData.getInt64(0, Endian.big);
  }

  double _bigEndianToDouble(List<int> bytes) {
    var byteBuffer = Uint8List.fromList(bytes).buffer;
    var dataView = ByteData.view(byteBuffer);
    var intValue = dataView.getInt64(0, Endian.little);
    // print(intValue);
    return intValue / 100000000;
  }

  int _bigEndianToInt(List<int> bytes) {
    var byteBuffer = Uint8List.fromList(bytes).buffer;
    var dataView = ByteData.view(byteBuffer);
    return dataView.getInt64(0, Endian.little);
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
