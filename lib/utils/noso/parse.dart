import 'package:nososova/models/node_info.dart';
import 'package:nososova/models/seed.dart';


class NosoParse {
 static NodeInfo parseResponseNode(List<int> response, Seed seedActive){
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