import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nososova/const.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/network/models/seed.dart';
import 'package:nososova/network/network_const.dart';

class AppState extends ChangeNotifier {
  /*
  1. Коли стартує апка вибираємо сід і підключаємось до нього
  2. Кожних 5хв тестуєм сіди чи доступні, і в залежності від пінгу міняємо дефолт сід
  3.
   */

  final MyDatabase _database;
  late List<Seed> seeds;

  List<String> debugInfo = [];
  Seed selectUseSeed = Seed();

  AppState(this._database) {
    seeds = Const.defaultSeed
        .map((ip) => Seed(ip: ip))
        .toList(); //це можна замінити на готовий список
    _connectToSeed();
  }

  void _connectToSeed() async {
    debugInfo.add("Start Connect");
    await _checkSeed();
    await _syncInformation();
  }

  // Перебираємо список сідів, і формуємо його для подальшого використання
  Future<void> _checkSeed() async {
    debugInfo.add("Check seeds...");
    for (var seed in seeds) {
      try {
        final clientSocket = await Socket.connect(seed.ip, 8080,
            timeout: const Duration(seconds: 4));
        final startTime = DateTime.now().millisecondsSinceEpoch;
        clientSocket.write(NetworkRequest.nodeStatus);
        final responseBytes = <int>[];
        await for (var byteData in clientSocket) {
          responseBytes.addAll(byteData);
        }
        final endTime = DateTime.now().millisecondsSinceEpoch;
        final responseTime = endTime - startTime;

        await clientSocket.close();

        if (responseBytes.isNotEmpty) {
          if (kDebugMode) {
            print("Server response time: $responseTime ms");
          }
          seed.ping = responseTime;
          seed.online = true;
        }
      } on TimeoutException catch (_) {
        if (kDebugMode) {
          print("Connection timed out. Check server availability.");
        }
        seed.online = false;
      } on SocketException catch (e) {
        if (kDebugMode) {
          print("SocketException: ${e.message}");
        }
        seed.online = false;
      } catch (e) {
        if (kDebugMode) {
          print("Unhandled Exception: $e");
        }
        seed.online = false;
      }
    }

    final onlineSeeds = seeds.where((seed) => seed.online).toList();
    if (onlineSeeds.isNotEmpty) {
      selectUseSeed = onlineSeeds.reduce((a, b) => a.ping < b.ping ? a : b);
      debugInfo.add("The smallest seed with the lowest ping is selected  ${selectUseSeed.ip}");
    } else {
      debugInfo.add("No working seeds were found");
    }

  }

  Future<void> _syncInformation() async {
      try {
        final clientSocket = await Socket.connect(selectUseSeed.ip, 8080,
            timeout: const Duration(seconds: 4));
        clientSocket.write(NetworkRequest.nodeStatus);
        final responseBytes = <int>[];
        await for (var byteData in clientSocket) {
          responseBytes.addAll(byteData);
        }
        await clientSocket.close();
        debugInfo.add("Information about the status of the node has been received");
        debugInfo.add("Seed connected -> ${selectUseSeed.ip}");

        if (responseBytes.isNotEmpty) {
          final response = String.fromCharCodes(responseBytes);
        }
      } on TimeoutException catch (_) {
        if (kDebugMode) {
          print("Connection timed out. Check server availability.");
        }
      } on SocketException catch (e) {
        if (kDebugMode) {
          print("SocketException: ${e.message}");
        }
      } catch (e) {
        if (kDebugMode) {
          print("Unhandled Exception: $e");
        }

    }

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
