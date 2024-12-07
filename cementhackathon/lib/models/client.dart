// client.dart
import 'visitProduct.dart'; // Ensure the correct path
import 'Location.dart';

class Client {
  final String name;
  final String responsible;
  final String email;
  final String phoneNumber;
  final bool isActive;
  final List<VisitProduct> products;
  final String observation;
  final Location location;

  Client({
    required this.name,
    required this.responsible,
    required this.email,
    required this.phoneNumber,
    this.isActive = true,
    required this.products,
    this.observation = '',
    required this.location,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'],
      responsible: json['responsible'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      isActive: json['isActive'] ?? true,
      products: json['products'] != null
          ? (json['products'] as List)
          .map((item) => VisitProduct.fromJson(item))
          .toList()
          : [], // Handle null case
      observation: json['observation'] ?? '',
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'responsible': responsible,
      'email': email,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
      'products': products.map((product) => product.toJson()).toList(),
      'observation': observation,
      'location': location.toJson(),
    };
  }
}
