import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  // Redirect to the next screen after a delay
  _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to the next screen (replace with your next screen)
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFD9D9D9), Color(0xFF737373)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo image
              Image.asset(
                'assets/images/logo.png',
                width: 150,  // Adjust size accordingly
                height: 150,
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                'Cement Industry Hub',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,  // Red color for attention-grabbing title
                ),
              ),
              const SizedBox(height: 20),
              // Progress bar or Loading indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
              const SizedBox(height: 30),
              // Footer text
              Text(
                'Building the Future with Cement',
                style: TextStyle(
                  color: Colors.white54, // Light gray text for footer
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
