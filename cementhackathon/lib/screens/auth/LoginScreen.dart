import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/InputField.dart';
import '../../controllers/AuthController.dart';
// Adjust if necessary

class LoginScreen extends StatelessWidget {
  // Define controllers for email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginController = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Logo
                Container(
                  width: size.width * 0.45,
                  height: size.width * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset("assets/images/logo.png").image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                // Welcome Text
                const Text(
                  'Welcome back! Glad to see you again',
                  style: TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 35),

                // Email Field
                InputField(
                  controller: _emailController, // Use the controller
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  errorMessage: loginController.emailError,
                ),
                const SizedBox(height: 18),

                // Password Field
                InputField(
                  controller: _passwordController, // Use the controller
                  label: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  errorMessage: loginController.passwordError,
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF303030),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                loginController.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          // Get email and password from controllers
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          await loginController.login(email, password, context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(size.width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33),
                          ),
                          backgroundColor: const Color(0xFFD42027),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                const SizedBox(height: 10),

                // Help Text
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Have any trouble? ',
                    style: TextStyle(
                      color: Color(0xFF303030),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: 'Contact us',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (loginController.errorMessage.isNotEmpty)
                  Text(
                    loginController.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
