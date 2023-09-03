import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static const String lastSeed = "lastSeed";
  static const String lastBlock = "lastBlock";

  late SharedPreferences _prefs;

  SharedService._();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  factory SharedService() {
    final instance = SharedService._();
    instance.init();
    return instance;
  }

  Future<void> saveLastSeed(String ipPort) async {
    await _prefs.setString(lastSeed, ipPort);
  }

  Future<String?> loadLastSeed() async {
    return _prefs.getString(lastSeed);
  }

  Future<void> saveLastBlock(String lastBlock) async {
    await _prefs.setString(lastBlock, lastBlock);
  }

  Future<String?> loadLastBlock() async {
    return _prefs.getString(lastBlock);
  }
}
