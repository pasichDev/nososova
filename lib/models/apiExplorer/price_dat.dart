class PriceData {
  final String timestamp;
  final double price;

  PriceData({required this.timestamp, required this.price});

  factory PriceData.fromJson(Map<String, dynamic> json) {
    return PriceData(
      timestamp: json['timestamp'],
      price: json['price'],
    );
  }

}
