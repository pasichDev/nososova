import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/models/app/responses/response_api.dart';

import '../models/block_mns.dart';

class ExplorerStatsService {
  final String _apiExplorerHttp = "https://api.nosostats.com:8078";
  final String _apiStats = "https://api.nosocoin.com/";

  getResponseRpc(String method, dynamic params) async {
    return await http.post(
      Uri.parse(_apiExplorerHttp),
      headers: {'Origin': 'https://api.nosostats.com'},
      body: jsonEncode(
          {"jsonrpc": "2.0", "method": method, "params": params, "id": 20}),
    );
  }

  Future<ResponseApi> fetchBlockMNS(int blockHeight) async {
    var response = await getResponseRpc("getblockmns", [blockHeight]);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      List<dynamic> resultList = jsonData['result'];
      return ResponseApi(
          value: BlockMNS_RPC(
              block: resultList[0]['block'],
              reward: resultList[0]['reward'] * 0.00000001,
              total: resultList[0]['total'] * 0.00000001));
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
      return ResponseApi(
          errors: 'Request failed with status: ${response.statusCode}');
    }
  }

  Future<ResponseApi> fetchHistoryTransactions(String addressHash) async {
    final response = await http.get(
      Uri.parse(
          "${_apiStats}transactions/history?address=$addressHash&limit=100"),
      headers: {"accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<TransactionHistory> list = [];

      if (jsonData['error'] != null) {
        return ResponseApi(errors: jsonData['error']);
      } else {
        for (Map<String, dynamic> item in jsonData['inbound']) {
          list.add(TransactionHistory.fromJson(item));
        }
        for (Map<String, dynamic> item in jsonData['outbound']) {
          list.add(TransactionHistory.fromJson(item));
        }
        return ResponseApi(value: list);
      }
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
      return ResponseApi(
          errors: 'Request failed with status: ${response.statusCode}');
    }
  }
}
