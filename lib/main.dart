import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/screens/main_navigation_screen.dart';
import 'package:expense_tracker/screens/welcome_screen.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/screens/signup_screen.dart';
import 'package:expense_tracker/models/expense_provider.dart';
import 'package:expense_tracker/models/theme_provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => ExpenseProvider()),
    ],
    child: const ExpenseTrackerApp(),
  ),
);

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Expense Tracker Pro',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme.themeData,
          // UPDATED NAMED ROUTES
          initialRoute: '/welcome', // Start the user journey here
          routes: {
            '/welcome': (context) => const WelcomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/home': (context) => const MainNavigationScreen(),       // Main app with navigation
          },
        );
      },
    );
  }
}