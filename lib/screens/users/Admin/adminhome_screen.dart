import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importa las fuentes de Google Fonts
import 'package:simp/Theme/app_theme.dart';
import 'package:simp/screens/users/Admin/viewsreports_screen.dart';
import 'package:simp/screens/users/Admin/viewspiscinas_screen.dart';
import 'package:simp/screens/users/Admin/viewsusers_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  final String adminName;

  const AdminHomeScreen({Key? key, required this.adminName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 20.0),
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
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Perfil',
                    child: Text(
                      'Perfil',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 55, 140, 210),
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.patrickHandSc().fontFamily,
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Ajustes',
                    child: Text(
                      'Ajustes',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 55, 140, 210),
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Logout',
                    child: Container(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 55, 140, 210),
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.patrickHandSc().fontFamily,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ];
              },
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
            alignment: Alignment.center,
          ),
          // Contenido sobre la imagen de fondo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido $adminName',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pool_sharp),
            label: 'Piscinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
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
                MaterialPageRoute(
                  builder: (context) => const ViewsUsersScreen(
                    userList: [],
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewPiscinasScreen(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewsDataScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
