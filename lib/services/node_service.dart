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

        if (command != NetworkRequest.summary) {
          print("${String.fromCharCodes(responseBytes)}, seed -> ${seed.ip}");
        }

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
      print("Errro");
      return ResponseNode(errors: "SocketException: ${e.message}");
    } catch (e) {
      if (kDebugMode) {
        print("ServerService Exception: $e");
      }
      return ResponseNode(errors: "ServerService Exception: $e");
    }
  }

  Future<Socket> _connectSocket(Seed seed) async {
    return Socket.connect(seed.ip, seed.port,
        timeout: const Duration(seconds: NetworkConst.durationTimeOut));
  }
}
