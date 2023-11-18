import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nososova/utils/const/const.dart';

import '../models/currency_model.dart';

class LiveCoinWatchService {
  Future<CurrencyModel?> fetchMarketInfo() async {
    DateTime now = DateTime.now();

    int currentTimestamp = now.millisecondsSinceEpoch;
    int yesterdayTimestamp =
        now.subtract(const Duration(days: 1)).millisecondsSinceEpoch;

    Map<String, dynamic> requestData = {
      "currency": "USD",
      "code": Const.coinName,
      "start": yesterdayTimestamp,
      "end": currentTimestamp,
      "meta": true
    };

    String apiUrl = 'https://api.livecoinwatch.com/coins/single/history';
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': dotenv.env['api_token_livecoinwatch'] ?? "",
      },
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      for (var currency in CurrencyModel.fromJson(jsonData).history) {
       // print('Name: ${currency.date}');
        DateTime date = DateTime.fromMillisecondsSinceEpoch(currency.date);

        print('Formatted Date: ${ DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(currency.date).toLocal())}');
        // і так далі...
      }
      return CurrencyModel.fromJson(jsonData);




    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}');
      }
    }
    return null;
  }
}
