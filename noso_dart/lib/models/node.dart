import 'package:noso_dart/models/seed.dart';

class Node {
  Seed seed;
  int connections;
  int lastblock;
  int pendings;
  int delta;
  String branch;
  String version;
  int utcTime;

  Node({
    required this.seed,
    this.connections = 0,
    this.lastblock = 0,
    this.pendings = 0,
    this.delta = 0,
    this.branch = "",
    this.version = "",
    this.utcTime = 0,
  });

  Node copyWith({
    Seed? seed,
    int? connections,
    int? lastblock,
    int? pendings,
    int? delta,
    String? branch,
    String? version,
    int? utcTime,
  }) {
    return Node(
      seed: seed ?? this.seed,
      connections: connections ?? this.connections,
      lastblock: lastblock ?? this.lastblock,
      pendings: pendings ?? this.pendings,
      delta: delta ?? this.delta,
      branch: branch ?? this.branch,
      version: version ?? this.version,
      utcTime: utcTime ?? this.utcTime,
    );
  }

  Node? parseResponseNode(List<int>? response, Seed seedActive) {
    if (response == null) {
      return null;
    }
    List<String> values = String.fromCharCodes(response).split(" ");

    if (values.length <= 2) {
      return null;
    }

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
}
