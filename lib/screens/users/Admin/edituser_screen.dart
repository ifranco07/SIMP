import 'package:flutter/material.dart';
import 'viewsusers_screen.dart';

class EditUserScreen extends StatelessWidget {
  final User user;

  const EditUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Editar usuario: ${user.name}',
              style: const TextStyle(fontSize: 20),
            ),
            // Aquí agregar campos de edición para el usuario
            // Puedes agregar campos de texto, botones, etc.
            ElevatedButton(
              onPressed: () {
                // Implementa la lógica para guardar los cambios y volver a la pantalla anterior
                Navigator.pop(context);
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
