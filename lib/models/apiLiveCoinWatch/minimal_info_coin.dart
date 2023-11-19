import 'package:json_annotation/json_annotation.dart';

part 'minimal_info_coin.g.dart';

@JsonSerializable()
class MinimalInfoCoin {
  String name;
  int rank;
  int age;
  String color;
  String png32;
  String png64;
  String webp32;
  String webp64;
  int exchanges;
  int markets;
  int pairs;
  List<String> categories;
  double allTimeHighUSD;
  int circulatingSupply;
  int totalSupply;
  int maxSupply;
  Links links;
  double rate;
  int volume;
  int cap;
  int liquidity;
  Delta delta;

  MinimalInfoCoin({
    required this.name,
    required this.rank,
    required this.age,
    required this.color,
    required this.png32,
    required this.png64,
    required this.webp32,
    required this.webp64,
    required this.exchanges,
    required this.markets,
    required this.pairs,
    required this.categories,
    required this.allTimeHighUSD,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.links,
    required this.rate,
    required this.volume,
    required this.cap,
    required this.liquidity,
    required this.delta,
  });

  factory MinimalInfoCoin.fromJson(Map<String, dynamic> json) =>
      _$MinimalInfoCoinFromJson(json);

  Map<String, dynamic> toJson() => _$MinimalInfoCoinToJson(this);
}

@JsonSerializable()
class Links {
  String? website;
  String? whitepaper;
  String? twitter;
  String? reddit;
  String? telegram;
  String? discord;
  String? medium;
  String? instagram;

  Links({
    this.website,
    this.whitepaper,
    this.twitter,
    this.reddit,
    this.telegram,
    this.discord,
    this.medium,
    this.instagram,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Delta {
  double? hour;
  double? day;
  double? week;
  double? month;
  double? quarter;
  double? year;

  Delta({
    this.hour,
    this.day,
    this.week,
    this.month,
    this.quarter,
    this.year,
  });

  factory Delta.fromJson(Map<String, dynamic> json) => _$DeltaFromJson(json);

  Map<String, dynamic> toJson() => _$DeltaToJson(this);
}
