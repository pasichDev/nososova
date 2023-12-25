import 'package:intl/intl.dart';

class DateUtil{
  static String getUtcTime(int unixTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000, isUtc: true);
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}