class PriceItem {
  PriceItem({
    String priceId,
    String label = "",
    String description = "",
    double price = 0,
    String currency = 'DT',
    int totalStock: 0,
    int reservedStock: 0,
  })  : this.priceId = priceId,
        this.label = label,
        this.description = description,
        this.price = price,
        this.currency = currency,
        this.totalStock = totalStock,
        this.reservedStock = reservedStock,
        this.availableStock = totalStock - reservedStock;
  final String priceId;
  final String label;
  final String description;
  final double price;
  final String currency;
  final int totalStock;
  final int reservedStock;
  final int availableStock;

  factory PriceItem.fromJson(dynamic json) {
    print(json);
    return PriceItem(
        priceId: json['_id'],
        description: json['description'] as String,
        price: json['price'] + 0.0,
        label: json['label'] as String,
        totalStock: json['totalStock'],
        reservedStock: json['reservedStock']);
  }
}
