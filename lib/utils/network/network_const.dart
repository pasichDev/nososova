import 'package:flutter/material.dart';

final class NetworkRequest {
  static const String nodeStatus = "NODESTATUS\n";
  static const String nodeList = "NSLMNS\n";
  static const String pendingsList = "NSLPEND\n";
}

class CheckConnect {
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

class NetworkConst {
  static const int durationTimeOut = 5;
  static const int delaySync = 15;
}

enum InitialNodeAlgh { listenDefaultNodes, connectLastNode, listenUserNodes }

enum StatusConnectNodes { statusConnected, statusError, statusLoading }
