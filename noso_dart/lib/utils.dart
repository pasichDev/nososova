class OtherUtils {
  static int getCountMonetToRunNode() {
    return 10500;
  }

  static bool isValidHashNoso(String hash) {
    if (hash.length < 3 || hash.length > 32) {
      return false;
    }
    return true;
  }

  static String hashObfuscation(String hash) {
    if (hash.length >= 25) {
      return "${hash.substring(0, 9)}...${hash.substring(hash.length - 9)}";
    }
    return hash;
  }
}
