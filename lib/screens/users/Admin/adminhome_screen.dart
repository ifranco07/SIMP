import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Administrador'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: const Center(
        child: Text(
          'Contenido de la pantalla de administrador',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
