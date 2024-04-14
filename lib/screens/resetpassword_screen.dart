import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});


  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

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
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Restablecer Contraseña'),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() async {
  String email = _emailController.text;

  // Verificar si el correo electrónico está registrado en la base de datos
  try {
    // Consultar la colección de usuarios en Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    // Si existe al menos un documento con este correo electrónico
    if (querySnapshot.docs.isNotEmpty) {
      // Enviar el correo con el código de seguridad
      String securityCode = _generateSecurityCode();
      await _sendEmail(email, securityCode);

      // Mostrar un mensaje de éxito
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Correo Enviado'),
            content: const Text('Se ha enviado un correo electrónico con instrucciones para restablecer tu contraseña.'),
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
    } else {
      // Si no se encuentra el correo electrónico en la base de datos
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No se encontró ningún usuario con este correo electrónico.'),
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
  } catch (e) {
    // Manejar errores
    print('Error al verificar el correo electrónico: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Ocurrió un error al verificar el correo electrónico.'),
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
}


  String _generateSecurityCode() {
    // Generar un código de seguridad aleatorio (aquí puedes implementar tu lógica personalizada)
    return '123456';
  }

  Future<void> _sendEmail(String email, String securityCode) async {
    String username = ''; // Tu dirección de correo electrónico
    String password = ''; // Tu contraseña de correo electrónico

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your Name') // Remitente
      ..recipients.add(email) // Destinatario
      ..subject = 'Código de Seguridad para Restablecer Contraseña'
      ..text = 'Tu código de seguridad para restablecer la contraseña es: $securityCode';

    try {
      await send(message, smtpServer);
      print('Correo electrónico enviado correctamente');
    } catch (e) {
      print('Error al enviar el correo electrónico: $e');
      throw Exception('Error al enviar el correo electrónico');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
