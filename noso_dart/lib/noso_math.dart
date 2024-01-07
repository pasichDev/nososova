import 'dart:typed_data';

import 'package:noso_dart/const.dart';

class NosoMath {
  double bigEndianToDouble(List<int> bytes) {
    var byteBuffer = Uint8List.fromList(bytes).buffer;
    var dataView = ByteData.view(byteBuffer);
    var intValue = dataView.getInt64(0, Endian.little);
    return intValue / 100000000;
  }

  int bigEndianToInt(List<int> bytes) {
    var byteBuffer = Uint8List.fromList(bytes).buffer;
    var dataView = ByteData.view(byteBuffer);
    return dataView.getInt64(0, Endian.little);
  }

  int getFee(int amount) {
    int result = amount ~/ NosoConst.comissiontrfr;
    if (result < NosoConst.minimumFee) {
      return NosoConst.minimumFee;
    }
    return result;
  }

  int convertAmount(dynamic amount) {
    if (amount is int) {
      return int.parse("${amount}00000000");
    }
    if (amount is double) {
      List<String> tempArray = amount.toString().split('.');

      while (tempArray[1].length < 8) {
        tempArray[1] += '0';
      }

      return int.parse(tempArray[0] + tempArray[1]);
    }

    return 0;
  }
}
