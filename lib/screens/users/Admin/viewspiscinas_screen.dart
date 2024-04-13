import 'package:flutter/material.dart';

class ViewPiscinasScreen extends StatelessWidget {
  const ViewPiscinasScreen({Key? key});

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
        title: const Text(
          'Piscinas',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de columnas en la cuadrícula
            crossAxisSpacing:
                16.0, // Espacio horizontal entre los elementos de la cuadrícula
            mainAxisSpacing:
                16.0, // Espacio vertical entre los elementos de la cuadrícula
            childAspectRatio:
                2, // Relación de aspecto de cada elemento (ancho / alto)
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
      bottomNavigationBar: _buildNavBar(), // Agregar el bottomNavigationBar
    );
  }

  Widget _buildNavBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              // Agrega aquí la lógica para el botón correspondiente
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 28,
                ),
                Text(
                  "Agregar",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Agrega aquí la lógica para el botón correspondiente
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home,
                  color: Colors.blue,
                  size: 28,
                ),
                Text(
                  "Inicio",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
