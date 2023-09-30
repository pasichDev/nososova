import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static const String lastSeed = "lastSeed";
  static const String lastBlock = "lastBlock";
  static const String listNodes = "nodesList";
  static const String delaySync = "delaySync";

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

  Future<void> saveLastSeed(String value) async {
    await _prefs.setString(lastSeed, value);
  }

  Future<String?> loadLastSeed() async {
    return _prefs.getString(lastSeed);
  }

  Future<void> saveLastBlock(int value) async {
    await _prefs.setInt(lastBlock, value);
  }

  Future<int?> loadLastBlock() async {
    return _prefs.getInt(lastBlock);
  }

  Future<void> saveListNodes(String value) async {
    await _prefs.setString(listNodes, value);
  }

  Future<String?> loadNodesList() async {
    return _prefs.getString(listNodes);
  }

  Future<void> saveDelaySync(int value) async {
    await _prefs.setInt(delaySync, value);
  }

  Future<int?> loadDelaySync() async {
    return _prefs.getInt(delaySync);
  }
}
