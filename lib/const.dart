

class Const {
  static const String b58Alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
  static const String b36Alphabet = "0123456789abcdefghijklmnopqrstuvwxyz";
  static const String b64Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  static const String coinChar = "N";
  static const String coinName= "NOSO";
  static const List<String> defaultSeed = [
    "47.87.181.190", "47.87.178.205", "66.151.117.247", "47.87.180.219",
    "47.87.137.96", "192.3.85.196", "192.3.254.186", "198.46.218.125",
    "20.199.50.27", "63.227.69.162", "81.22.38.101"
  ];
}

class StatusConnectNodes {
  static const int statusConnected = 1;
  static const int statusError = 0;
  static const int statusNoConnected = -1;
  static const int statusLoading = 2;
}