import 'package:nososova/models/node_info.dart';
import 'package:nososova/models/seed.dart';

class NosoParse {
  static List<Seed> parseMNString(String? response) {
    final resultMNList = <Seed>[];

    if (response != null) {
      final tokens = response.split(' ');
      tokens.skip(1); // Ignore Block Number

      for (final rawNodeInfo in tokens) {
        final sanitizedNodeInfo =
            rawNodeInfo.replaceAll(':', ' ').replaceAll(';', ' ');
        final nodeValues = sanitizedNodeInfo.split(' ');

        final nodeInfo = Seed()
          ..ip = nodeValues[0]
          ..port = int.tryParse(nodeValues[1])!
          ..nosoAddress = nodeValues[2]
          ..count = int.tryParse(nodeValues[3]);

        resultMNList.add(nodeInfo);
      }
    }

    return resultMNList;
  }

  static NodeInfo parseResponseNode(List<int> response, Seed seedActive) {
    List<String> values = String.fromCharCodes(response).split(" ");
    return NodeInfo(
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
}
