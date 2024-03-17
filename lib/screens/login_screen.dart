import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo/Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _loginUser(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) {
    // Aquí agregarías la lógica para validar el inicio de sesión
    // Puedes usar FirebaseAuth o cualquier otro método de autenticación.
    // Después de validar las credenciales del usuario, puedes redirigirlo a la interfaz correspondiente a su rol.
    // Por ahora, lo simularemos simplemente con un botón.

    // Simplemente navega a la pantalla de inicio después de iniciar sesión.
    Navigator.pushReplacementNamed(context, '/home');
  }
}
