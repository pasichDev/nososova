// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_info_coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullInfoCoin _$FullInfoCoinFromJson(Map<String, dynamic> json) => FullInfoCoin(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      rank: json['rank'] as int? ?? 0,
      age: json['age'] as int? ?? 0,
      color: json['color'] as String? ?? '',
      png32: json['png32'] as String? ?? '',
      png64: json['png64'] as String? ?? '',
      webp32: json['webp32'] as String? ?? '',
      webp64: json['webp64'] as String? ?? '',
      exchanges: json['exchanges'] as int? ?? 0,
      markets: json['markets'] as int? ?? 0,
      pairs: json['pairs'] as int? ?? 0,
      allTimeHighUSD: (json['allTimeHighUSD'] as num?)?.toDouble() ?? 0.0,
      circulatingSupply: json['circulatingSupply'] as int? ?? 0,
      totalSupply: json['totalSupply'] as int? ?? 0,
      maxSupply: json['maxSupply'] as int? ?? 0,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      history: (json['history'] as List<dynamic>?)
              ?.map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FullInfoCoinToJson(FullInfoCoin instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
      'rank': instance.rank,
      'age': instance.age,
      'color': instance.color,
      'png32': instance.png32,
      'png64': instance.png64,
      'webp32': instance.webp32,
      'webp64': instance.webp64,
      'exchanges': instance.exchanges,
      'markets': instance.markets,
      'pairs': instance.pairs,
      'allTimeHighUSD': instance.allTimeHighUSD,
      'circulatingSupply': instance.circulatingSupply,
      'totalSupply': instance.totalSupply,
      'maxSupply': instance.maxSupply,
      'categories': instance.categories,
      'history': instance.history,
    };

HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) => HistoryItem(
      date: json['date'] as int? ?? 0,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      volume: json['volume'] as int? ?? 0,
      cap: json['cap'] as int? ?? 0,
    );

Map<String, dynamic> _$HistoryItemToJson(HistoryItem instance) =>
    <String, dynamic>{
      'date': instance.date,
      'rate': instance.rate,
      'volume': instance.volume,
      'cap': instance.cap,
    };
