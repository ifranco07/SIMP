import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Piscina {
  final String nombre;

  Piscina({required this.nombre});
}

class ViewPiscinasScreen extends StatefulWidget {
  const ViewPiscinasScreen({super.key});

  @override
  _ViewPiscinasScreenState createState() => _ViewPiscinasScreenState();
}

class _ViewPiscinasScreenState extends State<ViewPiscinasScreen> {
  late CollectionReference piscinasCollection;
  List<Piscina> piscinas = [];

  @override
  void initState() {
    super.initState();
    // Obtener referencia a la colección "piscinas" en Firestore
    piscinasCollection = FirebaseFirestore.instance.collection('piscinas');
    // Cargar las piscinas del usuario actual
    _loadPiscinas();
  }

  void _loadPiscinas() async {
    // Obtener el usuario actual (puedes usar FirebaseAuth para esto)
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Consultar el documento del usuario actual en Firestore
      final userData = await piscinasCollection.doc(currentUser.uid).get();
      if (userData.exists) {
        // Si el documento existe, cargar las piscinas del usuario
        setState(() {
          piscinas = (userData['piscinas'] as List<dynamic>).map((piscinaData) {
            return Piscina(nombre: piscinaData['nombre']);
          }).toList();
        });
      } else {
        // Si el documento no existe, crearlo con una lista vacía de piscinas
        await piscinasCollection.doc(currentUser.uid).set({
          'piscinas': [],
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 2,
          ),
          itemCount: piscinas.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: InkWell(
                onTap: () {
                  // Agregar lógica para mostrar detalles de la piscina
                },
                child: Center(
                  child: Text(
                    piscinas[index].nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _agregarPiscina(); // Lanzar el formulario de registro de piscina
        },
        child: const Icon(Icons.add),
      ),
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
            child: const Column(
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
            child: const Column(
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

  void _agregarPiscina() async {
    // Aquí va la lógica para agregar una nueva piscina manualmente
    final TextEditingController _nombreController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Piscina'),
          content: TextField(
            controller: _nombreController,
            decoration: const InputDecoration(
              hintText: 'Nombre de la piscina',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Guardar la piscina en Firestore
                await _guardarPiscina(_nombreController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _guardarPiscina(String nombrePiscina) async {
  try {
    // Obtener el usuario actual (puedes usar FirebaseAuth para esto)
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Consultar el documento del usuario actual en Firestore
      DocumentSnapshot userData = await piscinasCollection.doc(currentUser.uid).get();

      if (userData.exists) {
        // Si el documento existe, actualizar la lista de piscinas
        List<dynamic> piscinas = userData['piscinas'];
        piscinas.add({'nombre': nombrePiscina});
        
        // Guardar la lista actualizada en Firestore
        await piscinasCollection.doc(currentUser.uid).update({
          'piscinas': piscinas,
        });

        // Actualizar el estado para reflejar el cambio en la lista de piscinas
        setState(() {
          this.piscinas = piscinas.map((piscinaData) {
            return Piscina(nombre: piscinaData['nombre']);
          }).toList();
        });
      } else {
        // Si el documento no existe, crearlo con la lista de piscinas
        await piscinasCollection.doc(currentUser.uid).set({
          'piscinas': [{'nombre': nombrePiscina}],
        });
        // Agregar la nueva piscina a la lista local
        setState(() {
          this.piscinas = [Piscina(nombre: nombrePiscina)];
        });
      }
    }
  } catch (e) {
    print('Error al guardar la piscina: $e');
  }
}

}
