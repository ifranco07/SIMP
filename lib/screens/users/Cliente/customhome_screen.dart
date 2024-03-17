import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class CustomHomeScreen extends StatelessWidget {
  const CustomHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Cliente'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: const Center(
        child: Text(
          'Contenido de la pantalla de cliente',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
