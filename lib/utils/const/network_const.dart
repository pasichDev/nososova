import 'package:flutter/material.dart';

import '../../models/seed.dart';

final class NetworkConst {
  static const int durationTimeOut = 5;
  static const int delaySync = 60;

  static List<Seed> defaultSeed = [
    Seed(ip: "47.87.181.190"),
    Seed(ip: "47.87.178.205"),
    Seed(ip: "66.151.117.247"),
    Seed(ip: "47.87.180.219"),
    Seed(ip: "47.87.137.96"),
    Seed(ip: "192.3.85.196"),
    Seed(ip: "192.3.254.186"),
    Seed(ip: "198.46.218.125"),
    Seed(ip: "20.199.50.27"),
    Seed(ip: "63.227.69.162"),
    Seed(ip: "81.22.38.101"),
  ];
}

final class NetworkRequest {
  static const String nodeStatus = "NODESTATUS\n";
  static const String nodeList = "NSLMNS\n";
  static const String pendingsList = "NSLPEND\n";
  static const String summary = "GETZIPSUMARY\n";
}

final class CheckConnect {
  static IconData getStatusConnected(StatusConnectNodes status) {
    switch (status) {
      case StatusConnectNodes.statusConnected:
        return Icons.computer;
      case StatusConnectNodes.statusError:
        return Icons.report_gmailerrorred_outlined;
      case StatusConnectNodes.statusLoading:
        return Icons.downloading;
      default:
        return Icons.signal_wifi_connected_no_internet_4;
    }
  }
}


enum InitialNodeAlgh { listenDefaultNodes, connectLastNode, listenUserNodes }

enum StatusConnectNodes { statusConnected, statusError, statusLoading }

enum ConsensusStatus { sync, error }

