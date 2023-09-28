import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nososova/models/response_node.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/utils/network/network_const.dart';

class ServerService {

  final List<Seed> _defaultSeed = [
    Seed(ip: "47.87.181.190"),
    Seed(ip: "47.87.178.205"),
    Seed(ip: "66.151.117.247"),
    Seed(ip: "47.87.180.219"),
    Seed(ip: "47.87.137.96"),
    Seed(ip: "192.3.85.196"),
    Seed(ip: "192.3.254.186"),
    Seed(ip: "198.46.218.125"),
    Seed(ip: "20.199.50.27"),
    Seed(ip: "63.227.69.162"),
    Seed(ip: "81.22.38.101"),
  ];

  /*
   final clientSocket = await _connectSocket(seed);
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
   */


  Future<ResponseNode<List<int>>> fetchNode(String command, Seed seed) async {
    final responseBytes = <int>[];
    try {
      var socket = await _connectSocket(seed);
      final startTime = DateTime.now().millisecondsSinceEpoch;
      socket.write(command);
      await for (var byteData in socket) {
        responseBytes.addAll(byteData);
      }
      final endTime = DateTime.now().millisecondsSinceEpoch;
      final responseTime = endTime - startTime;

      socket.close();
      if (responseBytes.isNotEmpty) {
        seed.ping = responseTime;
        seed.online = true;
        return ResponseNode(value: responseBytes, seed: seed);
      } else {
        return ResponseNode(errors: "Empty response");
      }
    } on TimeoutException catch (_) {
      if (kDebugMode) {
        print("Connection timed out. Check server availability.");
      }
      return ResponseNode(
          errors: "Connection timed out. Check server availability.");
    } on SocketException catch (e) {
      if (kDebugMode) {
        print("SocketException: ${e.message}");
      }
      return ResponseNode(errors: "SocketException: ${e.message}");
    } catch (e) {
      if (kDebugMode) {
        print("Unhandled Exception: $e");
      }
      return ResponseNode(errors: "Unhandled Exception: $e");
    }
  }

  /// Метод який перебирає дефолтні сіди, і поаертає активний сід
  Future<ResponseNode> testsListDefaultSeeds() async {
    for (var seed in _defaultSeed) {
      try {
        seed = await _testPingNode(seed);
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
    final onlineSeeds = _defaultSeed.where((seed) => seed.online).toList();
    if (onlineSeeds.isNotEmpty) {
      ResponseNode responseNode = ResponseNode(
          seed: onlineSeeds.reduce((a, b) => a.ping < b.ping ? a : b));
      return responseNode;
    } else {
      return ResponseNode(errors: "No working seeds were found");
    }
  }

  ///Метод який використовується для тестуваня підключення лише для останого сіду
  Future<ResponseNode> testLastSeed(Seed seed) async {
    try {
      seed = await _testPingNode(seed);
    } on TimeoutException catch (_) {
      if (kDebugMode) {
        print("Connection timed out. Check server availability.");
      }
      seed.online = false;
      return ResponseNode(
          seed: seed,
          errors: "Connection timed out. Check server availability.");
    } on SocketException catch (e) {
      if (kDebugMode) {
        print("SocketException: ${e.message}");
      }
      seed.online = false;
      return ResponseNode(seed: seed, errors: "SocketException: ${e.message}");
    } catch (e) {
      if (kDebugMode) {
        print("Unhandled Exception: $e");
      }
      seed.online = false;
      return ResponseNode(seed: seed, errors: "Unhandled Exception: $e");
    }
    return ResponseNode(seed: seed);
  }

  Future<Seed> _testPingNode(Seed seed) async {
    final clientSocket = await _connectSocket(seed);
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
    return seed;
  }

  Future<Socket> _connectSocket(Seed seed) async {
    return Socket.connect(seed.ip, seed.port,
        timeout: const Duration(seconds: NetworkConst.durationTimeOut));
  }
}
