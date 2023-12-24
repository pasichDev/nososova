

class UtilsDataNoso {
  static int getCountMonetToRunNode() {
    return 10500;
  }


  static isValidHashNoso(String hash){
    if (hash.length < 3 ||
        hash.length > 32){
      return false;
    }
    return true;
  }
}
