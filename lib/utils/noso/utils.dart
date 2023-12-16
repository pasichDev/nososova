import '../const/const.dart';

class UtilsDataNoso {
  static int getCountMonetToRunNode() {
    return 10500;
  }

  static double getFee(double amount) {
    double result = amount / Const.comissiontrfr;

    if (result < Const.minimumFee) {
      return Const.minimumFee;
    }

    return result;
  }
}
