import '../const/const.dart';

class UtilsDataNoso {
  static int getCountMonetToRunNode() {
    return 10500;
  }

  static double getFee(double amount) {
    double result = amount / Const.Comisiontrfr;

    if (result < Const.MinimunFee) {
      return Const.MinimunFee;
    }

    return result;
  }
}
