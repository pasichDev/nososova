import 'package:nososova/generated/assets.dart';

import '../../models/seed.dart';

final class NetworkConst {
  static const int durationTimeOut = 5;
  static const int delaySync = 30;

  static List<Seed> defaultSeed = [
    Seed(ip: "4.233.61.8"),
    Seed(ip: "5.230.55.203"),
    Seed(ip: "141.11.192.215"),
    Seed(ip: "104.234.60.55"),
    Seed(ip: "107.172.214.53"),
    Seed(ip: "198.23.134.105"),
    Seed(ip: "20.199.50.27"),
  ];
}

final class NetworkRequest {
  static const String nodeStatus = "NODESTATUS\n";
  static const String nodeList = "NSLMNS\n";
  static const String pendingsList = "NSLPEND\n";
  static const String summary = "GETZIPSUMARY\n";
}

final class CheckConnect {
  static String getStatusConnected(StatusConnectNodes status) {
    switch (status) {
      case StatusConnectNodes.connected:
        return Assets.iconsNodeI;
      case StatusConnectNodes.error:
        return Assets.iconsClose;
      default:
        return "";
    }
  }
}


enum InitialNodeAlgh { listenDefaultNodes, connectLastNode, listenUserNodes }

enum StatusConnectNodes { connected, error, searchNode, sync}

/// Connected - підключено
/// error - помилка
/// searchNode - пошук вузла
/// sync - синхронізація

enum ConsensusStatus { sync, error }

