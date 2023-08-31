final class StatusQrScan {
  static const int qrError = 0;
  static const int qrAddress = 1;
  static const int qrKeys = 2;

  static int checkQrScan(String dataScan) {
    if (dataScan.length >= 30 && dataScan.length <= 32) {
      return qrAddress;
    } else if (dataScan.length == 133) {
      return qrKeys;
    }
    return qrError;
  }
}
