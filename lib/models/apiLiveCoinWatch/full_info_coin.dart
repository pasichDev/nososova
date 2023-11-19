import 'package:json_annotation/json_annotation.dart';

part 'full_info_coin.g.dart';

@JsonSerializable()
class FullInfoCoin {
  @JsonKey(defaultValue: "")
  String code;

  @JsonKey(defaultValue: "")
  String name;

  @JsonKey(defaultValue: "")
  String symbol;

  @JsonKey(defaultValue: 0)
  int rank;

  @JsonKey(defaultValue: 0)
  int age;

  @JsonKey(defaultValue: "")
  String color;

  @JsonKey(defaultValue: "")
  String png32;

  @JsonKey(defaultValue: "")
  String png64;

  @JsonKey(defaultValue: "")
  String webp32;

  @JsonKey(defaultValue: "")
  String webp64;

  @JsonKey(defaultValue: 0)
  int exchanges;

  @JsonKey(defaultValue: 0)
  int markets;

  @JsonKey(defaultValue: 0)
  int pairs;

  @JsonKey(defaultValue: 0.0)
  double allTimeHighUSD;

  @JsonKey(defaultValue: 0)
  int circulatingSupply;

  @JsonKey(defaultValue: 0)
  int? totalSupply;

  @JsonKey(defaultValue: 0)
  int? maxSupply;

  @JsonKey(defaultValue: [])
  List<String> categories;

  @JsonKey(defaultValue: [])
  List<HistoryItem> history;

  HistoryItem getLastHistoryItem() {
    if (history.isNotEmpty) {
      return history.last;
    } else {
      return HistoryItem();
    }
  }

  FullInfoCoin({
    this.code = "",
    this.name = "",
    this.symbol = "",
    this.rank = 0,
    this.age = 0,
    this.color = "",
    this.png32 = "",
    this.png64 = "",
    this.webp32 = "",
    this.webp64 = "",
    this.exchanges = 0,
    this.markets = 0,
    this.pairs = 0,
    this.allTimeHighUSD = 0.0,
    this.circulatingSupply = 0,
    this.totalSupply,
    this.maxSupply,
    this.categories = const [],
    this.history = const [],
  });

  factory FullInfoCoin.fromJson(Map<String, dynamic> json) =>
      _$FullInfoCoinFromJson(json);

  Map<String, dynamic> toJson() => _$FullInfoCoinToJson(this);
}

@JsonSerializable()
class HistoryItem {
  @JsonKey(defaultValue: 0)
  int date;

  @JsonKey(defaultValue: 0.0)
  double rate;

  @JsonKey(defaultValue: 0)
  int volume;

  @JsonKey(defaultValue: 0)
  int cap;

  HistoryItem({
    this.date = 0,
    this.rate = 0.0,
    this.volume = 0,
    this.cap = 0,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryItemToJson(this);
}
