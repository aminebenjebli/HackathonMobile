import 'dart:convert';
import 'package:dio/dio.dart';

class ProductService {
  final Dio _dio;
  final String baseUrl;

  ProductService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Create a new product
  Future<Map<String, dynamic>> createProduct(Map<String, dynamic> productData) async {
    try {
      final response = await _dio.post(
        '/product',
        data: json.encode(productData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  // Get all products
  Future<List<dynamic>> getAllProducts() async {
    try {
      final response = await _dio.get(
        '/product',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get all products: $e');
    }
  }

  // Get a specific product by ID
  Future<Map<String, dynamic>> getProductById(String id) async {
    try {
      final response = await _dio.get(
        '/product/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get product by ID: $e');
    }
  }

  // Update a specific product by ID
  Future<Map<String, dynamic>> updateProduct(String id, Map<String, dynamic> productData) async {
    try {
      final response = await _dio.put(
        '/product/$id',
        data: json.encode(productData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  // Delete a specific product by ID
  Future<void> deleteProduct(String id) async {
    try {
      await _dio.delete(
        '/product/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
