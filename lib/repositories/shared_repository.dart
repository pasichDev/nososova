import 'package:nososova/services/shared_service.dart';

class SharedRepository {
  final SharedService _sharedService;

  SharedRepository(this._sharedService);

  Future<void> saveLastSeed(String ipPort) async {
    await _sharedService.saveLastSeed(ipPort);
  }

  Future<String?> loadLastSeed() async {
    return _sharedService.loadLastSeed();
  }

  Future<void> saveLastBlock(String block) async {
    await _sharedService.saveLastBlock(block);
  }

  Future<String?> loadLastBlock() async {
    return _sharedService.loadLastBlock();
  }
}
