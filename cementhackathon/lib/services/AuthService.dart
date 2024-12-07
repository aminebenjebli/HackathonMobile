import 'package:dio/dio.dart';

import '../models/User.dart';
import '../models/login.dart';

class AuthService {
  final Dio _dio;
  final String baseUrl;

  AuthService(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<User> signUp(User user) async {
    try {
      final response = await _dio.post(
        '/auth/sign-up',
        data: user.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<Login> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/sign-in',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return Login.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    try {
      await _dio.post(
        '/auth/verify-otp',
        data: {
          'email': email,
          'otp': otp,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      await _dio.post(
        '/auth/resend-otp',
        data: {
          'email': email,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to resend OTP: $e');
    }
  }

  Future<void> refreshToken(String refreshToken) async {
    try {
      await _dio.post(
        '/auth/refresh-token',
        data: {
          'refreshToken': refreshToken,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to refresh token: $e');
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      await _dio.post(
        '/auth/forget-password',
        data: {
          'email': email,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to forget password: $e');
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    try {
      await _dio.post(
        '/auth/reset-password',
        data: {
          'email': email,
          'password': newPassword,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }
}
