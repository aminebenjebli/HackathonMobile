import 'package:cement_flutter/controllers/ClientController.dart';
import 'package:cement_flutter/core/routes.dart';
import 'package:cement_flutter/screens/Calender/CalendarScreen.dart';
import 'package:cement_flutter/screens/IntroScreen.dart';
import 'package:cement_flutter/screens/MapScreen.dart';
import 'package:cement_flutter/screens/SplashScreen.dart';
import 'package:cement_flutter/screens/Stat/history_stats.dart';
import 'package:cement_flutter/screens/Stat/rates_stats.dart';
import 'package:cement_flutter/screens/Stat/total_incomes_stat.dart';
import 'package:cement_flutter/screens/home/HomeScreen.dart';
import 'package:cement_flutter/screens/product/product_screen.dart';
import 'package:cement_flutter/screens/profile/settings/SettingsScreen.dart';
import 'package:cement_flutter/screens/clients/CreateClientPage.dart';
import 'package:cement_flutter/screens/visites/CreateVisitPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/AuthController.dart';
import 'screens/auth/LoginScreen.dart';
import 'screens/profile/UserProfileScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthController()),
          ChangeNotifierProvider(
              create: (_) => CreateClientController()), // Add ClientController
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              primary: const Color(0xFFD42027),
              onPrimary: const Color(0xFFFBEEEE),
              seedColor: const Color(0xFF16A666),
              secondary: const Color(0xFF9C9899),
              onSecondary: const Color(0xFFF9FAFC),
              surface: const Color(0xFFF9FAFC),
              onSurface: const Color(0xFF2F2F2F),
            ),
            useMaterial3: true,
          ),
          routes: {
            Routes.intro: (context) => IntroScreen(),
            Routes.login: (context) => LoginScreen(),
            Routes.profile: (context) => UserProfileScreen(),
            Routes.home: (context) => HomeScreen(),
            Routes.calendar_screen: (context) => const CalendarScreen(),
            Routes.UserProfileScreen: (context) => UserProfileScreen(),
            Routes.settings: (context) => SettingsScreen(),
            Routes.CreateVisitPage: (context) => CreateVisitPage(),
            Routes.CreateClientPage: (context) => CreateClientPage(),
            Routes.historyStat: (context) => HistoryStats(),
            Routes.rateStat: (context) => RateStats(),
            Routes.stats_page: (context) => StatisticsPage(),
            Routes.products_screen: (context) => ProductScreen(),
            Routes.SplashScreen: (context) => SplashScreen(),
            Routes.maps: (context) => const MapScreen()

            // Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
            // Routes.forgotPasswordOtp: (context) => const ForgotPasswordOtpScreen(),
            //Routes.main: (context) => const MainScreen(),
          },
          initialRoute: Routes.home,
        ));
  }
}
