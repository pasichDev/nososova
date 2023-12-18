import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/utils/const/network_const.dart';

import '../models/responses/response_node.dart';

class NodeService {
  List<Seed> seedsDefault = [];

  NodeService() {
    seedsDefault = NetworkConst.getSeedList();
  }

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
      if (kDebugMode) {
       if(command != NetworkRequest.summary) print(String.fromCharCodes(responseBytes));
      }

      socket.close();
      if (responseBytes.isNotEmpty) {
        seed.ping = responseTime;
        seed.online = true;
        return ResponseNode(value: responseBytes, seed: seed);
      } else {
        return command == NetworkRequest.pendingsList
            ? ResponseNode(value: [])
            : ResponseNode(errors: "Empty response");
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
        print("ServerService Exception: $e");
      }
      return ResponseNode(errors: "ServerService Exception: $e");
    }
  }





  Future<ResponseNode<List<int>>> getRandomDevNode() async {
    final responseBytes = <int>[];
    Random random = Random();
    int randomIndex = random.nextInt(seedsDefault.length);
    var targetSeed = seedsDefault[randomIndex];
    try {
      var socket = await _connectSocket(targetSeed);
      final startTime = DateTime.now().millisecondsSinceEpoch;
      socket.write(NetworkRequest.nodeStatus);
      await for (var byteData in socket) {
        responseBytes.addAll(byteData);
      }
      final endTime = DateTime.now().millisecondsSinceEpoch;
      final responseTime = endTime - startTime;

      socket.close();
      if (responseBytes.isNotEmpty) {
        targetSeed.ping = responseTime;
        targetSeed.online = true;
        return ResponseNode(value: responseBytes, seed: targetSeed);
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
        print("ServerService Exception: $e");
      }
      return ResponseNode(errors: "ServerService Exception: $e");
    }
  }


  /// Метод який перебирає дефолтні сіди, і поаертає активний сід
  Future<ResponseNode<List<Seed>>> testsListDefaultSeeds() async {
    for (var seed in seedsDefault) {
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
    final onlineSeeds = seedsDefault.where((seed) => seed.online).toList();
    if (onlineSeeds.isNotEmpty) {
      ResponseNode<List<Seed>> responseNode = ResponseNode(
          seed: onlineSeeds.reduce((a, b) => a.ping < b.ping ? a : b),
          value: onlineSeeds);
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
