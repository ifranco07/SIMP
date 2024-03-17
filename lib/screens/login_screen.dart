import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'users/Admin/adminhome_screen.dart';
import 'users/Cliente/customhome_screen.dart';
import 'users/User/userhome_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        leading: Image.asset(
          'lib/assets/images/Logo.png',
          width: 50,
          height: 50,
        ),
        backgroundColor: const Color.fromARGB(255, 70, 200, 243),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu correo/usuario';
                }
                // Validar que el correo/usuario contenga letras, números y caracteres especiales
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Correo/usuario inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu contraseña';
                }
                // Validar que la contraseña contenga letras, números y caracteres especiales
                final passwordRegex = RegExp(r'^[\w@-]*$');
                if (!passwordRegex.hasMatch(value)) {
                  return 'Contraseña inválida';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs(context)) {
                  _loginUser(context);
                }
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

  bool _validateInputs(BuildContext context) {
    final isValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos'),
        ),
      );
    }
    return isValid;
  }

  void _loginUser(BuildContext context) {
    // Aquí irá la lógica para validar el inicio de sesión y redirigir al usuario según su rol.
    // Por ahora, simplemente redireccionaremos a la pantalla correspondiente al rol de usuario.
    // Ejemplo:
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
    );
  }
}
