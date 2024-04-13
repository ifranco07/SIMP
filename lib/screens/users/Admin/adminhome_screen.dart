import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simp/screens/users/Admin/viewsreports_screen.dart';
import 'package:simp/screens/users/Admin/viewspiscinas_screen.dart';
import 'package:simp/screens/users/Admin/viewsusers_screen.dart';
import 'package:simp/screens/users/Cliente/datapool_screen.dart';
import 'package:simp/screens/users/Cliente/reportsviews_screen.dart.dart';

class AdminHomeScreen extends StatefulWidget {
  final String adminName;

  const AdminHomeScreen({Key? key, required this.adminName}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  final List<IconData> _navIcons = [
    Icons.people_outline,
    Icons.pool_sharp,
    Icons.receipt_outlined,
    Icons.account_circle, // Icono para usuarios
    Icons.logout, // Icono para cerrar sesión
  ];

  final List<String> _navTitle = [
    "Usuarios",
    "Piscinas",
    "Reportes",
    "Usuarios", // Título para usuarios
    "Logout", // Título para cerrar sesión
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Aquí va la imagen
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/POOL.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  '¡Bienvenido ${widget.adminName}!',
                  style: GoogleFonts.bungee(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 44,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildNavBar(),
          ),
        ],
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
        children: List.generate(
          _navIcons.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              _onItemTapped(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _navIcons[index],
                  color: _selectedIndex == index ? Colors.blue : Colors.grey,
                  size: 28,
                ),
                Text(
                  _navTitle[index],
                  style: TextStyle(
                    color: _selectedIndex == index ? Colors.blue : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewsUsersScreen(userList: []),
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
            builder: (context) => ViewsreportsScreen(),
          ),
        );
        break;
      case 3:
        // Navegar a la pantalla de usuarios (aquí puedes implementar la navegación según tus necesidades)
        break;
      case 4:
        // Cerrar sesión (aquí puedes implementar la lógica para cerrar sesión)
        break;
    }
  }
}
