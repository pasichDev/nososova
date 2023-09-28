import 'package:nososova/models/seed.dart';

class NodeInfo {
  Seed seed;
  int connections;
  int lastblock;
  int pendings;
  int delta;
  String branch;
  String version;
  int utcTime;

  NodeInfo({
    required this.seed,
    this.connections = 0,
    this.lastblock = 0,
    this.pendings = 0,
    this.delta = 0,
    this.branch = "",
    this.version = "",
    this.utcTime = 0,
  });

  NodeInfo copyWith({
    Seed? seed,
    int? connections,
    int? lastblock,
    int? pendings,
    int? delta,
    String? branch,
    String? version,
    int? utcTime,
  }) {
    return NodeInfo(
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
}
