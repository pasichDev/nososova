class AppUserInformation {
  int _totalBalance;
  int _block;
  int _price;
  int _totalIncoming;
  int _totalOutgoing;

  AppUserInformation({
    int totalBalance = 0,
    int block = 0,
    int price = 0,
    int totalIncoming = 0,
    int totalOutgoing = 0,
  })  : _totalBalance = totalBalance,
        _block = block,
        _price = price,
        _totalIncoming = totalIncoming,
        _totalOutgoing = totalOutgoing;

  // Getters
  int get totalBalance => _totalBalance;
  int get block => _block;
  int get price => _price;
  int get totalIncoming => _totalIncoming;
  int get totalOutgoing => _totalOutgoing;

  // Setters
  set totalBalance(int value) {
    _totalBalance = value;
  }

  set block(int value) {
    _block = value;
  }

  set price(int value) {
    _price = value;
  }

  set totalIncoming(int value) {
    _totalIncoming = value;
  }

  set totalOutgoing(int value) {
    _totalOutgoing = value;
  }
}
