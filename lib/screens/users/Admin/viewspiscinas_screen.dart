import 'package:flutter/material.dart';

class ViewPiscinasScreen extends StatelessWidget {
  const ViewPiscinasScreen({super.key});

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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de columnas en la cuadrícula
            crossAxisSpacing: 16.0, // Espacio horizontal entre los elementos de la cuadrícula
            mainAxisSpacing: 16.0, // Espacio vertical entre los elementos de la cuadrícula
            childAspectRatio: 2, // Relación de aspecto de cada elemento (ancho / alto)
          ),
          itemCount: piscinas.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3, // Agregamos elevación a la tarjeta
              child: InkWell(
                onTap: () {
                  // Agregar lógica para mostrar detalles de la piscina
                },
                child: Center(
                  child: Text(
                    piscinas[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
