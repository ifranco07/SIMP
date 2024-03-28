import 'package:flutter/material.dart';

class ViewPiscinasScreen extends StatelessWidget {
  const ViewPiscinasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ejemplo de lista de piscinas
    List<String> piscinas = [
      'Piscina 1',
      'Piscina 2',
      'Piscina 3',
      // Agrega más piscinas aquí según sea necesario
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Piscinas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Piscinas Disponibles:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: piscinas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(piscinas[index]),
                      onTap: () {
                        // Agregar lógica para mostrar detalles de la piscina
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
