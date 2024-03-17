import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'users/Admin/adminhome_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Administrador'),
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
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(
                  color: AppTheme.secondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                labelStyle: TextStyle(
                  color: AppTheme.secondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                labelStyle: TextStyle(
                  color: AppTheme.secondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailPhoneController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico o Teléfono',
                labelStyle: TextStyle(
                  color: AppTheme.secondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  color: AppTheme.secondaryColor,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar Contraseña',
                labelStyle: TextStyle(
                  color: AppTheme.secondaryColor,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: Text(
                'He leído y acepto los términos y condiciones',
                style: TextStyle(
                  color: _acceptTerms ? Colors.black : Colors.red, // Cambiar el color del texto si no se ha aceptado
                ),
              ),
              value: _acceptTerms,
              onChanged: (value) {
                setState(() {
                  _acceptTerms = value!;
                });
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Aquí deberías abrir la página de términos y condiciones
                // Puedes implementarlo según la estructura de tu aplicación
              },
              child: const Text('Ver Política de Términos y Condiciones'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  _registerUser(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    final isValid = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _emailPhoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _acceptTerms; // Agregando la validación del checkbox de términos y condiciones
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos y acepta los términos y condiciones'),
        ),
      );
    }
    return isValid;
  }

  void _registerUser(BuildContext context) {
    // Aquí iría la lógica para registrar al administrador y redirigirlo a su pantalla de inicio.
    // Por ahora, simplemente redireccionaremos a la pantalla correspondiente al rol de administrador.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
    );
  }
}
