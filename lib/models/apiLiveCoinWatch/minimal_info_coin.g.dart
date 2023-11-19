// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minimal_info_coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinimalInfoCoin _$MinimalInfoCoinFromJson(Map<String, dynamic> json) =>
    MinimalInfoCoin(
      name: json['name'] as String,
      rank: json['rank'] as int,
      age: json['age'] as int,
      color: json['color'] as String,
      png32: json['png32'] as String,
      png64: json['png64'] as String,
      webp32: json['webp32'] as String,
      webp64: json['webp64'] as String,
      exchanges: json['exchanges'] as int,
      markets: json['markets'] as int,
      pairs: json['pairs'] as int,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allTimeHighUSD: (json['allTimeHighUSD'] as num).toDouble(),
      circulatingSupply: json['circulatingSupply'] as int,
      totalSupply: json['totalSupply'] as int,
      maxSupply: json['maxSupply'] as int,
      links: Links.fromJson(json['links'] as Map<String, dynamic>),
      rate: (json['rate'] as num).toDouble(),
      volume: json['volume'] as int,
      cap: json['cap'] as int,
      liquidity: json['liquidity'] as int,
      delta: Delta.fromJson(json['delta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinimalInfoCoinToJson(MinimalInfoCoin instance) =>
    <String, dynamic>{
      'name': instance.name,
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
      'categories': instance.categories,
      'allTimeHighUSD': instance.allTimeHighUSD,
      'circulatingSupply': instance.circulatingSupply,
      'totalSupply': instance.totalSupply,
      'maxSupply': instance.maxSupply,
      'links': instance.links,
      'rate': instance.rate,
      'volume': instance.volume,
      'cap': instance.cap,
      'liquidity': instance.liquidity,
      'delta': instance.delta,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      website: json['website'] as String?,
      whitepaper: json['whitepaper'] as String?,
      twitter: json['twitter'] as String?,
      reddit: json['reddit'] as String?,
      telegram: json['telegram'] as String?,
      discord: json['discord'] as String?,
      medium: json['medium'] as String?,
      instagram: json['instagram'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'website': instance.website,
      'whitepaper': instance.whitepaper,
      'twitter': instance.twitter,
      'reddit': instance.reddit,
      'telegram': instance.telegram,
      'discord': instance.discord,
      'medium': instance.medium,
      'instagram': instance.instagram,
    };

Delta _$DeltaFromJson(Map<String, dynamic> json) => Delta(
      hour: (json['hour'] as num?)?.toDouble(),
      day: (json['day'] as num?)?.toDouble(),
      week: (json['week'] as num?)?.toDouble(),
      month: (json['month'] as num?)?.toDouble(),
      quarter: (json['quarter'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeltaToJson(Delta instance) => <String, dynamic>{
      'hour': instance.hour,
      'day': instance.day,
      'week': instance.week,
      'month': instance.month,
      'quarter': instance.quarter,
      'year': instance.year,
    };
