import 'package:flutter/material.dart';

import '../core/routes.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image Section
            Image(image: Image.asset('assets/images/intro.png').image),

            // Text Section
            Column(
              children: [
                Text(
                  'Welcome to Sotacib',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF303030),
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Here where you will find your tasks to complete them.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF303030),
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                SizedBox(height: size.width * 0.1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.width * 0.03,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(size.width * .6, 0)),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),

            //   Get Started Button
          ],
        ),
      ),
    );
  }
}
