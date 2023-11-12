import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  String nameFileSummary = "sumary.psk";

  /// Save summary file
  Future<bool> saveSummary(List<int> bytesValue) async {
    final Uint8List bytes = Uint8List.fromList(bytesValue);
    int breakpoint = 0;
    try {
      final directory = await getApplicationSupportDirectory();
      for (var index = 0; index < bytes.length - 4; index++) {
        if (bytes[index] == 0x50 &&
            bytes[index + 1] == 0x4b &&
            bytes[index + 2] == 0x03 &&
            bytes[index + 3] == 0x04) {
          breakpoint = index;
          break;
        }
      }
      if (breakpoint != 0) {
        final Uint8List modifiedBytes = bytes.sublist(breakpoint);
        var archive = ZipDecoder().decodeBytes(modifiedBytes);
        for (var file in archive.files) {
          if (file.isFile) {
            final outputStream =
                OutputFileStream('${directory.path}/${file.name}');
            file.writeContent(outputStream);
            outputStream.close();
          }

          return true;
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print("FileService Exception: $e");
      }
      return false;
    }
  }

  Future<Uint8List?> loadSummary() async {
    try {
      final directory = await getApplicationSupportDirectory();
      final filePsk = File("${directory.path}/data/$nameFileSummary");
      if (filePsk.existsSync()) {
        return await filePsk.readAsBytes();
      } else {
        if (kDebugMode) {
          print('File not found');
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("FileService Exception: $e");
      }
      return null;
    }
  }

  void cleanSummary() {}

  Future<Uint8List> readBytesFromPlatformFile(
      PlatformFile? platformFile) async {
    if (platformFile == null || platformFile.path == null) {
      return Uint8List(0);
    }
    try {
      File file = File(platformFile.path!);
      final byteData = await file.readAsBytes();
      return byteData.buffer.asUint8List();
    } catch (e) {
      if (kDebugMode) {
        print('Error reading file: $e');
      }
      return Uint8List(0);
    }
  }
}
