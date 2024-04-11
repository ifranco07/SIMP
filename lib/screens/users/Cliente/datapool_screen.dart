import 'package:flutter/material.dart';

class DataPoolScreen extends StatelessWidget {
  const DataPoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de la Piscina'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nivel de Sólidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '80%', // Aquí puedes mostrar el nivel de sólidos real de la piscina
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'pH',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '7.2', // Aquí puedes mostrar el pH real de la piscina
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Temperatura del Agua',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '28°C', // Aquí puedes mostrar la temperatura real del agua de la piscina
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Control de Luces',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: true, // Puedes vincular esto al estado real de las luces de la piscina
              onChanged: (value) {
                // Puedes implementar aquí la lógica para controlar las luces de la piscina
              },
            ),
          ],
        ),
      ),
    );
  }
}
