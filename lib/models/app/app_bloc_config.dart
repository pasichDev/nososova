import '../../utils/const/network_const.dart';

class AppBlocConfig {
  late String? _lastSeed;
  late String? _nodesList;
  late int? _lastBlock;
  int _delaySync = NetworkConst.delaySync;
  bool _isOneStartup = true;

  AppBlocConfig({
    String? lastSeed,
    String? nodesList,
    int? lastBlock,
    int? delaySync,
    bool? isOneStartup,
  }) {
    _lastSeed = lastSeed;
    _nodesList = nodesList;
    _lastBlock = lastBlock;
    _delaySync = delaySync ?? NetworkConst.delaySync;
    _isOneStartup = isOneStartup ?? false;
  }

  String? get lastSeed => _lastSeed;
  String? get nodesList => _nodesList;
  int? get lastBlock => _lastBlock;
  int get delaySync => _delaySync;
  bool get isOneStartup => _isOneStartup;
  AppBlocConfig copyWith({
    String? lastSeed,
    String? nodesList,
    int? lastBlock,
    int? delaySync,
    bool? isOneStartup,
  }) {
    return AppBlocConfig(
      lastSeed: lastSeed ?? _lastSeed,
      nodesList: nodesList ?? _nodesList,
      lastBlock: lastBlock ?? _lastBlock,
      delaySync: delaySync ?? _delaySync,
      isOneStartup:  _isOneStartup = isOneStartup ?? false
    );
  }


}
