import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nososova/models/apiExplorer/transaction_history.dart';

import '../models/apiExplorer/block_info.dart';
import '../models/apiExplorer/price_dat.dart';
import '../models/responses/response_api.dart';

class ExplorerStatsService {
  final String _apiStats = "https://api.nosocoin.com/";

  Future<ResponseApi> fetchHistoryTransactions(String addressHash) async {
    final response = await _fetchExplorerStats(
        "${_apiStats}transactions/history?address=$addressHash&limit=100");

    if (response.errors != null) {
      return response;
    } else {
      List<TransactionHistory> list = [];

      if (response.value['error'] != null) {
        return ResponseApi(errors: response.value['error']);
      } else {
        for (Map<String, dynamic> item in response.value['inbound']) {
          list.add(TransactionHistory.fromJson(item));
        }
        for (Map<String, dynamic> item in response.value['outbound']) {
          list.add(TransactionHistory.fromJson(item));
        }
        return ResponseApi(value: list);
      }
    }
  }

  Future<ResponseApi> fetchHistoryPrice() async {
    var response = await _fetchExplorerStats(
        "${_apiStats}info/price?range=day&interval=10");

    if (response.errors != null) {
      return response;
    }
    else {
      List<PriceData> listPrice = List<PriceData>.from(
          response.value.map((item) => PriceData.fromJson(item)));

      if (listPrice.isEmpty) {
        return ResponseApi(errors: response.errors);
      } else {
        return ResponseApi(value: listPrice);
      }
    }
  }

  Future<ResponseApi> fetchLastBlockInfo() async {
    var response = await _fetchExplorerStats("${_apiStats}nodes/info");

    if (response.errors != null) {
      return response;
    } else {
      return ResponseApi(value: BlockInfo.fromJson(response.value));
    }
  }

  Future<ResponseApi> _fetchExplorerStats(String uri) async {
    final response = await http.get(
      Uri.parse(uri),
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return ResponseApi(value: jsonData);
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
      return ResponseApi(
          errors: 'Request failed with status: ${response.statusCode}');
    }
  }
}
