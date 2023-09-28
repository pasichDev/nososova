import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:nososova/models/node_info.dart';
import 'package:nososova/models/seed.dart';
import 'package:nososova/utils/network/network_const.dart';
import 'package:nososova/utils/noso/parse.dart';

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

  Future<Socket> _connectSocket(Seed seed) async {
    return Socket.connect(seed.ip, seed.port,
        timeout: const Duration(seconds: NetworkConst.durationTimeOut));
  }

  Future<Seed> checkSeeds() async {
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
      return onlineSeeds.reduce((a, b) => a.ping < b.ping ? a : b);
      // debugInfo.add(
      //     "The smallest seed with the lowest ping is selected  ${_selectUseSeed.ip}");
    } else {
      return checkSeeds();
      //  debugInfo.add("No working seeds were found");
    }
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

  Future<Seed> testConnectionNode(Seed seed) async {
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
    return seed;
  }

  Future<NodeInfo> fetchNodeInfo(Seed seedActive) async {
    try {
      final clientSocket = await _connectSocket(seedActive);
      clientSocket.write(NetworkRequest.nodeStatus);
      final responseBytes = <int>[];
      await for (var byteData in clientSocket) {
        responseBytes.addAll(byteData);
      }
      await clientSocket.close();
      /*   debugInfo
          .add("Information about the status of the node has been received");
      debugInfo.add("Seed connected -> ${_selectUseSeed.ip}");

    */

      if (responseBytes.isNotEmpty) {
        return NosoParse.parseResponseNode(responseBytes, seedActive);
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
    return NodeInfo(seed: seedActive);
  }


  Future<List<Seed>> fetchNodesList(Seed seedActive) async {
    try {
      final clientSocket = await _connectSocket(seedActive);
      clientSocket.write(NetworkRequest.nodeList);
      final responseBytes = <int>[];
      await for (var byteData in clientSocket) {
        responseBytes.addAll(byteData);
      }
      await clientSocket.close();
      /*   debugInfo
          .add("Information about the status of the node has been received");
      debugInfo.add("Seed connected -> ${_selectUseSeed.ip}");

    */

      if (responseBytes.isNotEmpty) {
        return NosoParse.parseMNString(String.fromCharCodes(responseBytes));
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
    return List.empty();
  }
}
