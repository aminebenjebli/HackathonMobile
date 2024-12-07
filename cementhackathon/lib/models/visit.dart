// visit.dart
class Visit {
  final String user;
  final String client;
  final List<VisitProduct> products;

  Visit({
    required this.user,
    required this.client,
    required this.products,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      user: json['user'],
      client: json['client'],
      products: (json['products'] as List)
          .map((item) => VisitProduct.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'client': client,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

// visit_product.dart
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
