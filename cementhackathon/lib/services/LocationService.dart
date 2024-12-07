import 'dart:convert';
import 'package:dio/dio.dart';

class LocationService {
  final Dio _dio;
  final String baseUrl;

  LocationService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Create a new location
  Future<Map<String, dynamic>> createLocation(Map<String, dynamic> locationData) async {
    try {
      final response = await _dio.post(
        '/location',
        data: json.encode(locationData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create location: $e');
    }
  }

  // Get all locations
  Future<List<dynamic>> getAllLocations() async {
    try {
      final response = await _dio.get(
        '/location',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get all locations: $e');
    }
  }

  // Get a specific location by ID
  Future<Map<String, dynamic>> getLocationById(String id) async {
    try {
      final response = await _dio.get(
        '/location/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get location by ID: $e');
    }
  }

  // Update a specific location by ID
  Future<Map<String, dynamic>> updateLocation(String id, Map<String, dynamic> locationData) async {
    try {
      final response = await _dio.patch(
        '/location/$id',
        data: json.encode(locationData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update location: $e');
    }
  }

  // Delete a specific location by ID
  Future<void> deleteLocation(String id) async {
    try {
      await _dio.delete(
        '/location/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to delete location: $e');
    }
  }
}
