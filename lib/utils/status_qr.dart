final class CheckQrCode {

  static TypeQrCode checkQrScan(String dataScan) {
    if (dataScan.length >= 30 && dataScan.length <= 32) {
      return TypeQrCode.qrAddress;
    } else if (dataScan.length == 133) {
      return TypeQrCode.qrKeys;
    }
    return TypeQrCode.none;
  }
}

enum TypeQrCode {
  qrAddress,
  qrKeys,
  none
}
