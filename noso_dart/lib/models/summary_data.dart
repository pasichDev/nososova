import 'dart:typed_data';

import 'package:noso_dart/noso_math.dart';

class SummaryData {
  String hash;
  String custom;
  double balance;
  int score;
  int lastOP;

  SummaryData({
    this.hash = "",
    this.custom = "",
    this.balance = 0,
    this.score = 0,
    this.lastOP = 0,
  });

  List<SummaryData> parseSumary(Uint8List bytes) {
    if (bytes.isEmpty) {
      return [];
    }
    final List<SummaryData> addressSummary = [];
    int index = 0;

    while (index + 106 <= bytes.length) {
      final sumData = SummaryData();

      sumData.hash = String.fromCharCodes(
          bytes.sublist(index + 1, index + bytes[index] + 1));

      sumData.custom = String.fromCharCodes(
          bytes.sublist(index + 42, index + 42 + bytes[index + 41]));
      sumData.balance =
          NosoMath().bigEndianToDouble(bytes.sublist(index + 82, index + 90));

      final scoreArray = bytes.sublist(index + 91, index + 98);
      if (!scoreArray.every((element) => element == 0)) {
        sumData.score = NosoMath().bigEndianToInt(scoreArray);
      }

      addressSummary.add(sumData);
      index += 106;
    }
    return addressSummary;
  }
}
