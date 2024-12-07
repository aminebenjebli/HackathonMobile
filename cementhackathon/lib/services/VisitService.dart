import 'dart:convert';
import 'package:dio/dio.dart';

class VisitService {
  final Dio _dio;
  final String baseUrl;

  VisitService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Create a new visit
  Future<Map<String, dynamic>> createVisit(Map<String, dynamic> visitData) async {
    try {
      final response = await _dio.post(
        '/visit',
        data: json.encode(visitData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create visit: $e');
    }
  }

  // Get all visits
  Future<List<dynamic>> getAllVisits() async {
    try {
      final response = await _dio.get(
        '/visit',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get all visits: $e');
    }
  }

  // Get a specific visit by ID
  Future<Map<String, dynamic>> getVisitById(String id) async {
    try {
      final response = await _dio.get(
        '/visit/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get visit by ID: $e');
    }
  }

  // Update a specific visit by ID
  Future<Map<String, dynamic>> updateVisit(String id, Map<String, dynamic> visitData) async {
    try {
      final response = await _dio.patch(
        '/visit/$id',
        data: json.encode(visitData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update visit: $e');
    }
  }

  // Delete a specific visit by ID
  Future<void> deleteVisit(String id) async {
    try {
      await _dio.delete(
        '/visit/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to delete visit: $e');
    }
  }
}
