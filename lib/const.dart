

class Const {
  static const String b58Alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
  static const String b36Alphabet = "0123456789abcdefghijklmnopqrstuvwxyz";
  static const String b64Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  static const String coinChar = "N";
  static const String coinName= "NOSO";
}

class StatusConnectNodes {
  static const int statusConnected = 1;
  static const int statusError = 0;
  static const int statusNoConnected = -1;
  static const int statusLoading = 2;
}