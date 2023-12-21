import 'dart:convert';

class Masternode {
  final String ipv4;
  final int port;
  final String address;

  Masternode({
    required this.ipv4,
    required this.port,
    required this.address,
  });

  factory Masternode.fromJson(Map<String, dynamic> json) {
    return Masternode(
      ipv4: json['ipv4'] ?? '',
      port: json['port'] ?? 0,
      address: json['address'] ?? '',
    );
  }
}

class BlockInfo {
  final int blockId;
  final double reward;
  final int count;
  final List<Masternode> masternodes;

  BlockInfo({
    required this.blockId,
    required this.reward,
    required this.count,
    required this.masternodes,
  });

  factory BlockInfo.fromJson(Map<String, dynamic> json) {
    List<Masternode> masternodesList = [];
    if (json['masternodes'] != null) {
      for (var node in json['masternodes']) {
        masternodesList.add(Masternode.fromJson(node));
      }
    }

    return BlockInfo(
      blockId: json['block_id'] ?? 0,
      reward: json['reward'] ?? 0.0,
      count: json['count'] ?? 0,
      masternodes: masternodesList,
    );
  }

  static BlockInfo parse(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return BlockInfo.fromJson(jsonMap);
  }

  String getMasternodesString() {
    return masternodes
        .map((node) => '${node.ipv4}:${node.port}|${node.address}')
        .join(',');
  }
}
