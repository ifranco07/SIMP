import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Usuario'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: const Center(
        child: Text(
          'Contenido de la pantalla de usuario',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
