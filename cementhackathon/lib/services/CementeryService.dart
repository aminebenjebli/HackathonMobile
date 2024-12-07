import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cement_flutter/models/cementery.dart';

class CementeryService {
  final Dio _dio;
  final String baseUrl;

  CementeryService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Cementery>> findAll() async {
    try {
      final response = await _dio.get('/cementery');
      List<dynamic> data = response.data;
      return data.map((item) => Cementery.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load cementeries: $e');
    }
  }

  Future<Cementery> findOne(String id) async {
    try {
      final response = await _dio.get('/cementery/$id');
      return Cementery.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load cementery: $e');
    }
  }

  Future<Cementery> create(Cementery cementery) async {
    try {
      final response = await _dio.post(
        '/cementery',
        data: json.encode(cementery.toJson()),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return Cementery.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create cementery: $e');
    }
  }

  Future<Cementery> update(String id, Cementery cementery) async {
    try {
      final response = await _dio.patch(
        '/cementery/$id',
        data: json.encode(cementery.toJson()),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return Cementery.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update cementery: $e');
    }
  }

  Future<void> remove(String id) async {
    try {
      final response = await _dio.delete('/cementery/$id');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete cementery');
      }
    } catch (e) {
      throw Exception('Failed to delete cementery: $e');
    }
  }
}
