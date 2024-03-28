import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'package:simp/screens/home_screen.dart';
import 'package:simp/screens/resetpassword_screen.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: AppTheme.lightTheme,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/LoginScreen': (context) => LoginScreen(),
        '/RegisterScreen': (context) => const RegisterScreen(),
        '/ResetPasswordScreen': (context) => const ResetPasswordScreen(),
      },
    );
  }
}
