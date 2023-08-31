class NetworkConfig {
  int _defaultSeed;
  int _block;

  NetworkConfig({int defaultSeed = 0, int block = 12578, i})
      : _defaultSeed = defaultSeed,
        _block = block;

  int get defaultSeed => _defaultSeed;
  int get block => _block;

  set totalBalance(int value) {
    _defaultSeed = value;
  }

  set block(int value) {
    _block = value;
  }
}
