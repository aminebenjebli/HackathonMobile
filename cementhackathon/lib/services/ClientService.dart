import 'dart:convert';
import 'package:dio/dio.dart';

class ClientService {
  final Dio _dio;
  final String baseUrl;

  ClientService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Create a new client
  Future<Map<String, dynamic>> createClient(Map<String, dynamic> clientData) async {
    print(clientData);
    try {
      final response = await _dio.post(
        '/client',
        data: json.encode(clientData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create client: $e');
    }
  }

  // Get all clients
  Future<List<dynamic>> getAllClients() async {
    try {
      final response = await _dio.get(
        '/client',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get all clients: $e');
    }
  }

  // Get a specific client by ID
  Future<Map<String, dynamic>> getClientById(String id) async {
    try {
      final response = await _dio.get(
        '/client/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get client by ID: $e');
    }
  }

  // Update a specific client by ID
  Future<Map<String, dynamic>> updateClient(String id, Map<String, dynamic> clientData) async {
    try {
      final response = await _dio.put(
        '/client/$id',
        data: json.encode(clientData),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update client: $e');
    }
  }

  // Delete a specific client by ID
  Future<void> deleteClient(String id) async {
    try {
      await _dio.delete(
        '/client/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to delete client: $e');
    }
  }
}
