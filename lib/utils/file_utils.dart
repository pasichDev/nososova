
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class FileUtils {

 static  Future<Uint8List> readBytesFromPlatformFile(PlatformFile? platformFile) async {
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