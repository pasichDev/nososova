import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:noso_dart/models/app_info.dart';
import 'package:noso_dart/models/seed.dart';
import 'package:nososova/generated/assets.dart';

final class NetworkConst {
  static const int durationTimeOut = 3;
  static const int delaySync = 30;
  static AppInfo appInfo = AppInfo(protocol: 1.0, appVersion: "NOSOSOVA_1_0");


  String getRandomNode(String? inputString) {
    List<String> elements = (inputString ?? "").split(',');
    int elementCount = elements.length;
    if (elementCount > 0 && inputString != null && inputString.isNotEmpty) {
      int randomIndex = Random().nextInt(elementCount);
      var targetSeed = elements[randomIndex].split("|")[0];
      return targetSeed;
    } else {
      var devNode = NetworkConst.getSeedList();
      int randomDev = Random().nextInt(devNode.length);
      return devNode[randomDev].toTokenizer();
    }
  }
  static List<Seed> getSeedList() {
    var string = dotenv.env['seeds_default'] ?? "";
    List<Seed> defSeed = [];
    for (String seed in string.split(" ")) {
      defSeed.add(Seed(ip: seed));
    }
    return defSeed;
  }
}

final class NetworkRequest {
  static const String nodeStatus = "NODESTATUS\n";
  static const String nodeList = "NSLMNS\n";
  static const String pendingsList = "NSLPEND\n";
  static const String summary = "GETZIPSUMARY\n";
  static const String aliasOrder = "NSLCUSTOM";
}

final class CheckConnect {
  static String getStatusConnected(StatusConnectNodes status) {
    switch (status) {
      case StatusConnectNodes.connected:
        return Assets.iconsNodeI;
      case StatusConnectNodes.error:
        return Assets.iconsClose;
      default:
        return Assets.iconsNode;
    }
  }
}

enum InitialNodeAlgh { listenDefaultNodes, connectLastNode, listenUserNodes }

enum StatusConnectNodes { connected, error, searchNode, sync, consensus }

/// Connected - підключено
/// error - помилка
/// searchNode - пошук вузла
/// sync - синхронізація

enum ConsensusStatus { sync, error }
