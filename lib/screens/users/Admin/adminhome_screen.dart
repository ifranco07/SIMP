import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'package:simp/screens/users/Admin/viewsusers_screen.dart';
import 'package:simp/screens/users/Admin/viewspiscinas_screen.dart';
import 'package:simp/screens/users/Admin/viewsdata_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  final String adminName; // Nombre del administrador

  const AdminHomeScreen({Key? key, required this.adminName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard Administrador'),
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
                        'Bienvenido $adminName', // Mostrar el nombre del administrador
                        style: AppTheme.lightTheme.textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Barra de navegación en el footer
        BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Usuarios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pool),
              label: 'Piscinas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Reportes',
            ),
          ],
          selectedItemColor: AppTheme.primaryColor,
          onTap: (int index) {
            // Manejar la navegación aquí según el índice seleccionado
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewsUsersScreen()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewPiscinasScreen()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewsDataScreen()),
                );
                break;
            }
          },
        ),
      ],
    );
  }
}
