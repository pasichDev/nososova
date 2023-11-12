import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:nososova/services/file_service.dart';

class FileRepository {
  final FileService _fileService;

  FileRepository(this._fileService);

  Future<Uint8List> readBytesFromPlatformFile(PlatformFile? value) async {
   return await _fileService.readBytesFromPlatformFile(value);
  }

  Future<bool> writeSummaryZip(List<int> bytes) async {
    return await _fileService.saveSummary(bytes);
  }

  Future<Uint8List?> loadSummary() async {
    return await _fileService.loadSummary();
  }
}
