class StatsInfoCoin {
  int totalCoin = 0;
  int totalNodesPeople = 0;

  StatsInfoCoin({
    this.totalCoin = 0,
    this.totalNodesPeople = 0,
  });

  StatsInfoCoin copyWith({
    int? totalCoin,
    int? totalNodesPeople,
  }) {
    return StatsInfoCoin(
      totalCoin: totalCoin ?? this.totalCoin,
      totalNodesPeople: totalNodesPeople ?? this.totalNodesPeople,
    );
  }
}
