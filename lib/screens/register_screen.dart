import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedUserRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        backgroundColor: AppTheme.primaryColor, // Usar el color primario definido en AppTheme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedUserRole,
              onChanged: (newValue) {
                setState(() {
                  _selectedUserRole = newValue;
                });
              },
              items: ['Admin', 'Cliente', 'Usuario Común']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Tipo de Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(
                    color: AppTheme
                        .secondaryColor), // Color secundario definido en AppTheme
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                    color: AppTheme
                        .secondaryColor), // Color secundario definido en AppTheme
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _registerUser(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppTheme.primaryColor, // Usar el color primario definido en AppTheme
                textStyle: const TextStyle(
                    color: Colors.white), // Texto blanco
              ),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) {
    // Aquí agregarías la lógica para registrar al usuario con el tipo de usuario seleccionado
    // y los datos ingresados.
    // Una vez que el usuario se registre exitosamente, podrías navegar a la pantalla de inicio.
    Navigator.pushReplacementNamed(context, '/home');
  }
}
