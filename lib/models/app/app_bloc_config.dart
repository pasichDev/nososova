import '../../utils/const/network_const.dart';

class AppBlocConfig {
  late String? _lastSeed;
  late String? _nodesList;
  late int? _lastBlock;
  int _delaySync = NetworkConst.delaySync;

  AppBlocConfig({
    String? lastSeed,
    String? nodesList,
    int? lastBlock,
    int? delaySync,
  }) {
    _lastSeed = lastSeed;
    _nodesList = nodesList;
    _lastBlock = lastBlock;
    _delaySync = delaySync ?? NetworkConst.delaySync;
  }

  String? get lastSeed => _lastSeed;
  String? get nodesList => _nodesList;
  int? get lastBlock => _lastBlock;
  int get delaySync => _delaySync;
  AppBlocConfig copyWith({
    String? lastSeed,
    String? nodesList,
    int? lastBlock,
    int? delaySync,
  }) {
    return AppBlocConfig(
      lastSeed: lastSeed ?? _lastSeed,
      nodesList: nodesList ?? _nodesList,
      lastBlock: lastBlock ?? _lastBlock,
      delaySync: delaySync ?? _delaySync,
    );
  }


}
