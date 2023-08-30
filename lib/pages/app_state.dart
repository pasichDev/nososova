import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:nososova/database/database.dart';

class AppState extends ChangeNotifier {
  final MyDatabase _database;

  AppState(this._database);

  Future<List<Wallet>> fetchDataWallets() async {
    final wallets = await _database.getWalletList();
    return wallets;
  }

  void deleteWallet(Wallet wallet) async {
    await _database.deleteWallet(wallet);
    notifyListeners();
  }

  void addWallet(Wallet wallet) async {
    await _database.addWallet(wallet);
    notifyListeners();
  }
}
