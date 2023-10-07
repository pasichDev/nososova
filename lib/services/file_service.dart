import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:nososova/models/app/responses/response_node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/utils/const/network_const.dart';

class FileService {

  void loadSummary(){

  }


  void saveSummary(){

  }

  void cleanSummary(){

  }

  Future<Uint8List> readBytesFromPlatformFile(PlatformFile? platformFile) async {
    if (platformFile == null || platformFile.path == null) {
      return Uint8List(0); // Return an empty byte array if platformFile or its path is null.
    }
    try {
      File file = File(platformFile.path!); // Convert PlatformFile to File
      final byteData = await file.readAsBytes();
      return byteData.buffer.asUint8List();
    } catch (e) {
      // Handle any errors that occur during reading.
      print('Error reading file: $e');
      return Uint8List(0); // Return an empty byte array in case of an error.
    }
  }
}
