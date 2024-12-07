import 'dart:convert';
import 'package:dio/dio.dart';

class VisitProductService {
  final Dio _dio;
  final String baseUrl;

  VisitProductService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Create a new visit product
  Future<Map<String, dynamic>> createVisitProduct(Map<String, dynamic> visitProductData) async {
    try {
      final response = await _dio.post(
        '/visit-product',
        data: json.encode(visitProductData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create visit product: $e');
    }
  }

  // Get all visit products
  Future<List<dynamic>> getAllVisitProducts() async {
    try {
      final response = await _dio.get(
        '/visit-product',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get all visit products: $e');
    }
  }

  // Get a specific visit product by ID
  Future<Map<String, dynamic>> getVisitProductById(String id) async {
    try {
      final response = await _dio.get(
        '/visit-product/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get visit product by ID: $e');
    }
  }

  // Update a specific visit product by ID
  Future<Map<String, dynamic>> updateVisitProduct(String id, Map<String, dynamic> visitProductData) async {
    try {
      final response = await _dio.patch(
        '/visit-product/$id',
        data: json.encode(visitProductData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update visit product: $e');
    }
  }

  // Delete a specific visit product by ID
  Future<void> deleteVisitProduct(String id) async {
    try {
      await _dio.delete(
        '/visit-product/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to delete visit product: $e');
    }
  }
}
