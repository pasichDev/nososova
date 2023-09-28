import 'package:flutter/material.dart';

final class NetworkRequest {
  static const String nodeStatus = "NODESTATUS\n";
  static const String nodeList = "NSLMNS\n";
}

class StatusConnectNodes {
  static const int statusConnected = 1;
  static const int statusError = 0;
 // static const int statusNoConnected = -1;
  static const int statusLoading = 2;

 static IconData getStatusConnected(int status) {
    switch (status) {
      case StatusConnectNodes.statusConnected:
        return Icons.computer;
      case StatusConnectNodes.statusError:
        return Icons.report_gmailerrorred_outlined;
      case StatusConnectNodes.statusLoading:
        return Icons.downloading;
    //  case StatusConnectNodes.statusNoConnected:
    //    return Icons.signal_wifi_connected_no_internet_4;
      default:
        return Icons.signal_wifi_connected_no_internet_4;
    }
  }
}

class NetworkConst {
  static const int durationTimeOut = 4;

}