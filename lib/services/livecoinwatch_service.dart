import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nososova/models/apiLiveCoinWatch/minimal_info_coin.dart';
import 'package:nososova/models/app/responses/response_api.dart';
import 'package:nososova/utils/const/const.dart';

import '../models/apiLiveCoinWatch/full_info_coin.dart';

class LiveCoinWatchService {
  Map<String, String> apiHeaders = {
    'Content-Type': 'application/json',
    'x-api-key': dotenv.env['api_token_livecoinwatch'] ?? "",
  };
  String apiHttp = "https://api.livecoinwatch.com/";

  Future<ResponseApi> fetchHistory() async {
    DateTime now = DateTime.now();

    int currentTimestamp = now.millisecondsSinceEpoch;
    int yesterdayTimestamp =
        now.subtract(const Duration(days: 1)).millisecondsSinceEpoch;

    Map<String, dynamic> requestData = {
      "currency": "USD",
      "code": Const.coinName,
      "start": yesterdayTimestamp,
      "end": currentTimestamp,
      "meta": false
    };

    var response = await http.post(
      Uri.parse('${apiHttp}coins/single/history'),
      headers: apiHeaders,
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      return ResponseApi(value: FullInfoCoin.fromJson(jsonData));
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
      return ResponseApi(
          errors: 'Request failed with status: ${response.statusCode}');
    }
  }

  Future<ResponseApi> fetchMinimalInfo() async {
    Map<String, dynamic> requestData = {
      "currency": "USD",
      "code": "NOSO",
      "meta": true
    };

    var response = await http.post(
      Uri.parse('${apiHttp}coins/single'),
      headers: apiHeaders,
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return ResponseApi(value: MinimalInfoCoin.fromJson(jsonData));

    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
      return ResponseApi(
          errors: 'Request failed with status: ${response.statusCode}');
    }
  }
}