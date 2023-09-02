import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/network/models/node_info.dart';
import 'package:nososova/network/models/seed.dart';

class AppState extends ChangeNotifier {
  final MyDatabase _database;
  late List<Seed> _seeds;

  final List<String> _debugInfo = [];
  Seed _selectUseSeed = Seed();
  NodeInfo _userNodeInfo = NodeInfo(seed: Seed());

  get debugInfo => _debugInfo;
  get userNode => _userNodeInfo;

  AppState(this._database) {
   // _seeds = Const.defaultSeed.map((ip) => Seed(ip: ip)).toList();
    _connectToSeed();
  }

  void _connectToSeed() async {
    debugInfo.add("Start Connect");
 //   await _checkSeed();
 //   await _syncInformation();
  }

  /**
   * Реалізацію запитів нод винести окремо
   */

  static const int durationTimeOut = 4;

  // Перебираємо список сідів, і формуємо його для подальшого використання
  /*
  Future<void> _checkSeed() async {
    debugInfo.add("Check seeds...");
    for (var seed in _seeds) {
      try {
        final clientSocket = await Socket.connect(seed.ip, 8080,
            timeout: const Duration(seconds: durationTimeOut));
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

    final onlineSeeds = _seeds.where((seed) => seed.online).toList();
    if (onlineSeeds.isNotEmpty) {
      _selectUseSeed = onlineSeeds.reduce((a, b) => a.ping < b.ping ? a : b);
      debugInfo.add(
          "The smallest seed with the lowest ping is selected  ${_selectUseSeed.ip}");
    } else {
      debugInfo.add("No working seeds were found");
    }
  }

  Future<void> _syncInformation() async {
    try {
      final clientSocket = await Socket.connect(_selectUseSeed.ip, 8080,
          timeout: const Duration(seconds: durationTimeOut));
      clientSocket.write(NetworkRequest.nodeStatus);
      final responseBytes = <int>[];
      await for (var byteData in clientSocket) {
        responseBytes.addAll(byteData);
      }
      await clientSocket.close();
      debugInfo
          .add("Information about the status of the node has been received");
      debugInfo.add("Seed connected -> ${_selectUseSeed.ip}");

      if (responseBytes.isNotEmpty) {

        /**
         * Цей метод зробити окремо
         */
        List<String> values = String.fromCharCodes(responseBytes).split(" ");
        _userNodeInfo = NodeInfo(
          seed: _selectUseSeed,
          connections: int.tryParse(values[1]) ?? 0,
          lastblock: int.tryParse(values[2]) ?? 0,
          pendings: int.tryParse(values[3]) ?? 0,
          delta: int.tryParse(values[4]) ?? 0,
          branch: values[5],
          version: values[6],
          utcTime: int.tryParse(values[7]) ?? 0,
        );
        notifyListeners();

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

   */

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
