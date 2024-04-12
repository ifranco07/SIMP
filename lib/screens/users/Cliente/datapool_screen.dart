import 'package:flutter/material.dart';
import 'package:simp/screens/users/Admin/adminhome_screen.dart';

class DataPoolScreen extends StatelessWidget {
  const DataPoolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de la Piscina'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            _buildDataCard(
              context,
              title: 'Nivel de Sólidos',
              data: '80%',
              color: Colors.blue,
            ),
            _buildDataCard(
              context,
              title: 'pH',
              data: '7.2',
              color: Colors.green,
            ),
            _buildDataCard(
              context,
              title: 'Temperatura del Agua',
              data: '28°C',
              color: Colors.orange,
            ),
            _buildDataCard(
              context,
              title: 'Control de Luces',
              data: '',
              color: Colors.red,
              child: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            _buildDataCard(
              context,
              title: '2 switch',
              data: '',
              color: Colors.red,
              child: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
            _buildDataCard(
              context,
              title: 'Luz Automatica',
              data: '',
              color: Colors.red,
              child: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white, // Color de fondo del BottomNavigationBar
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app,
                  color: Colors.black), // Ícono de cerrar sesión
              label: 'Cerrar Sesión',
            ),
          ],
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: (int index) {
            // Manejar la navegación aquí según el índice seleccionado
          },
        ),
      ),
    );
  }

  Widget _buildDataCard(
    BuildContext context, {
    required String title,
    required String data,
    required Color color,
    Widget? child,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            if (child != null)
              child
            else
              Text(
                data,
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
