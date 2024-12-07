import 'package:cement_flutter/models/login.dart';
import 'package:cement_flutter/services/AuthService.dart';
import 'package:flutter/cupertino.dart';

import '../core/routes.dart';

var baseUrl = "http://localhost:3050/api/v2";

class AuthController extends ChangeNotifier {
  final AuthService _loginService = AuthService(baseUrl);
  bool _isLoading = false;
  String _errorMessage = '';
  String emailError = '';
  String passwordError = '';

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  // Set error message
  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    // Validate email and password
    if (email.isEmpty) {
      emailError = 'Email cannot be empty';
      notifyListeners();
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emailError = 'Invalid email format';
      notifyListeners();
    } else {
      emailError = '';
    }

    if (password.isEmpty) {
      passwordError = 'Password cannot be empty';
      notifyListeners();
    } else if (password.length < 6) {
      passwordError = 'Password must be at least 6 characters';
      notifyListeners();
    } else {
      passwordError = '';
    }

    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      Login response = await _loginService.signIn(email, password);
      try {
        _isLoading = false;
        _errorMessage = '';
        emailError = '';
        passwordError = '';
        notifyListeners();

        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.home);
      } catch (e) {
        _isLoading = false;
        _errorMessage = 'Cannot save token';
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Invalid email or password';
      notifyListeners();
    }
  }
}
