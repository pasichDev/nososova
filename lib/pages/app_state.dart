import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:nososova/database/database.dart';

class AppState extends ChangeNotifier {
  final MyDatabase _database;

  AppState(this._database);

  Future<List<Address>> fetchDataWallets() async {
    final wallets = await _database.getWalletList();
    return wallets;
  }

  void deleteWallet(Address adr) async {
    await _database.deleteWallet(adr);
    notifyListeners();
  }

  void addWallet(Address adr) async {
    await _database.addWallet(adr);
    notifyListeners();
  }
}
