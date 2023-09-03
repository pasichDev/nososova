
final class NetworkRequest {
  static const String nodeStatus = "NODESTATUS\n";
  static const String nodeList = "NSLMNS\n";
}

class StatusConnectNodes {
  static const int statusConnected = 1;
  static const int statusError = 0;
  static const int statusNoConnected = -1;
  static const int statusLoading = 2;
}

class NetworkConst {
  static const int durationTimeOut = 4;

}