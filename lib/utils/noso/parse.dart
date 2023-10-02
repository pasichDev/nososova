import 'dart:math';

import 'package:nososova/database/database.dart';
import 'package:nososova/models/node.dart';
import 'package:nososova/models/seed.dart';

class NosoParse {
  static String parseMNString(List<int> response) {
    final resultMNList = <Seed>[];
    final StringBuffer parsedData = StringBuffer();

    final tokens = String.fromCharCodes(response).split(' ');
    if (tokens.length > 1) {
      tokens.skip(1); // Ignore Block Number

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

  static Node parseResponseNode(List<int> response, Seed seedActive) {
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

  static String getRandomNode(String? inputString) {
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

  static String getQrKeys(Address address) {
    return "${address.publicKey} ${address.privateKey}";
  }
}
