import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'package:simp/screens/users/Cliente/control_screen.dart';
import 'package:simp/screens/users/Cliente/control_screen.dart;

class CustomHomeScreen extends StatelessWidget {
  final String clienteName; // Nombre del cliente

  const CustomHomeScreen({super.key, required this.clienteName, required String customName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
         // Ajusta la altura del AppBar
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container( 
            padding: const EdgeInsets.only(top: 20.0),// Ajusta el padding para mover el AppBar hacia abajo
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.001),
                ],
              ),
            ),
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Ajusta el padding para el contenido del flexibleSpace
              child: Image.asset(
                'lib/assets/images/Logo.png',
                fit: BoxFit.contain,
                height: 150,
                width: 120,
              ),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String choice) {
                // Implementa la lógica para manejar la selección de las opciones del menú
                switch (choice) {
                  case 'Perfil':
                    // Implementa la lógica para abrir la pantalla de perfil
                    break;
                  case 'Ajustes':
                    // Implementa la lógica para abrir la pantalla de cuentas
                    break;
                  case 'Logout':
                    Navigator.popUntil(context, (route) => route.isFirst); 
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Perfil',
                    child: Text('Perfil'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Ajustes',
                    child: Text('Ajustes'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Image.asset(
            'lib/assets/images/POOL2.jpg', // Ruta de la imagen de fondo
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            alignment: Alignment.center, // Alinear la imagen al centro vertical y horizontalmente
          ),
          // Contenido sobre la imagen de fondo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido $clienteName', // Mostrar el nombre del cliente
                  style: AppTheme.lightTheme.textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.poll_outlined),
            label: 'Control Piscinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_saver_off),
            label: 'Datos Piscinas',
          ),
        ],
        selectedItemColor: AppTheme.primaryColor,
        onTap: (int index) {
          // Manejar la navegación aquí según el índice seleccionado
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ControlScreenconst()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DataPoolScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
