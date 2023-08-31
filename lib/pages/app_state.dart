import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:nososova/const.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/network/models/seed.dart';

class AppState extends ChangeNotifier {
  /*
  1. Коли стартує апка вибираємо сід і підключаємось до нього
  2. Кожних 5хв тестуєм сіди чи доступні, і в залежності від пінгу міняємо дефолт сід
  3.
   */


  final MyDatabase _database;

  late List<Seed> seeds;


  AppState(this._database){
    seeds = Const.defaultSeed.map((ip) => Seed(ip: ip)).toList(); //це можна замінити на готовий список
    //_connectToSeed();
  }

  void _connectToSeed() async {
    print('Підключено до серверу');
    _checkSeed();
  }


  /// Метод реалізує перебираня списку сідів, і вибирає найкращий
  /// Він повинен автоматично стартувати в фоні кожних 10хв
  void _checkSeed() async  {
    print('Перебирання сідів');
    for (var seed in seeds) {
      try {
        final result = await _ping(seed.ip);
        print('start ${seed.ip}');
        if (result) {
          seed.online = true;
          print('ok IP ${seed.ip}');
        }
      } catch (error) {
        print('Помилка пінгування для IP ${seed.ip}: $error');
      }
      // Оновлюємо стан для повідомлення про зміни
     // notifyListeners();
    }
  }



  Future<bool> _ping(String ip) async {
    final completer = Completer<bool>();

    try {
      final result = await InternetAddress.lookup(ip);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final start = DateTime.now();
        await Socket.connect(ip, 80, timeout: Duration(seconds: 3))
            .then((socket) {
          socket.close();
          final duration = DateTime.now().difference(start);
          if (duration.inMilliseconds <= 3000) {
            completer.complete(true);
          } else {
            completer.complete(false);
          }
        }).catchError((error) {
          completer.complete(false);
        });
      }
    } catch (error) {
      completer.complete(false);
    }

    return completer.future;
  }





























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
