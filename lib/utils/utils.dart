final class Utils {
 static double roundToTwoDecimalPlaces(double value) {
   return (value * 100).toDouble() / 100;
  }

 static String shortenNumber(double value) {
    if (value >= 1000) {
      if (value < 1000000) {
        return '${(value / 1000).toStringAsFixed(2)}K';
      } else {
        return '${(value / 1000000).toStringAsFixed(2)}M';
      }
    } else {
      return value.toString();
    }
  }
}
