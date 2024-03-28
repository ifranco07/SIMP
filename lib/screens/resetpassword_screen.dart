import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _securityCodeController = TextEditingController();

  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            const SizedBox(height: 16),
            if (_isAdmin)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recibirás un correo electrónico con un código de seguridad para restablecer tu contraseña.',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _securityCodeController,
                    decoration: const InputDecoration(labelText: 'Código de Seguridad'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: const InputDecoration(labelText: 'Nueva Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Confirmar Contraseña'),
                    obscureText: true,
                  ),
                ],
              )
            else
              // Text(
              //   'Pide a tu administrador que te proporcione tu contraseña.',
              //   style: TextStyle(color: Theme.of(context).primaryColor),
              // ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Restablecer Contraseña'),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    if (_isAdmin) {
      // Aquí puedes implementar la lógica para enviar el correo con el código de seguridad
      // y para restablecer la contraseña del administrador
    } else {
      // Muestra una alerta para el cliente indicando que debe contactar al administrador
      _showAlert(context);
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Restablecer Contraseña'),
          content: const Text('Pide a tu administrador que te proporcione tu contraseña.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _securityCodeController.dispose();
    super.dispose();
  }
}
