import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'users/Admin/adminhome_screen.dart';
import 'users/Cliente/customhome_screen.dart';
import 'resetpassword_screen.dart'; // Importa la pantalla de restablecimiento de contraseña

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/textura-agua-piscina.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4, // Ajusta el ancho del contenedor
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Ajusta la transparencia del fondo
                borderRadius: BorderRadius.circular(16.0),
              ),
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
                      // Aquí puedes agregar más validaciones si es necesario
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
                      // Aquí puedes agregar más validaciones si es necesario
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
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('O '),
                      Image.asset(
                        'lib/assets/images/Google.png', // Ruta de la imagen del logo de Google
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/ResetPasswordScreen'); // Navega hacia ResetPasswordScreen
                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12, // Ajusta el tamaño de la letra
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      MaterialPageRoute(builder: (context) => const AdminHomeScreen(adminName: '',)),
    );
  }
}
