class VisitProduct {
  final String cementery;
  final String product;
  final double price;

  VisitProduct({
    required this.cementery,
    required this.product,
    required this.price,
  });

  factory VisitProduct.fromJson(Map<String, dynamic> json) {
    return VisitProduct(
      cementery: json['cementery'],
      product: json['product'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cementery': cementery,
      'product': product,
      'price': price,
    };
  }
}