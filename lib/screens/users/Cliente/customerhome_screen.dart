import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simp/screens/home_screen.dart';
import 'package:simp/screens/users/Cliente/datapool_screen.dart';
import 'package:simp/screens/users/Cliente/reportsviews_screen.dart.dart';

class CustomerHomeScreen extends StatefulWidget {
  final String clienteName;

  const CustomerHomeScreen({Key? key, required this.clienteName})
      : super(key: key);

  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;

  final List<IconData> _navIcons = [
    Icons.document_scanner,
    Icons.storage,
    Icons.account_circle,
    Icons.logout,
  ];

  final List<String> _navTitle = [
    "Reportes",
    "Datos",
    "Perfil",
    "Logout",
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
                  '¡Bienvenido ${widget.clienteName}!',
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
              if (index < 2) {
                _onItemTapped(index);
              } else {
                if (_navTitle[index] == 'Perfil') {
                } else if (_navTitle[index] == 'Logout') {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              }
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
          MaterialPageRoute(builder: (context) => const ViewsreportsScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DataPoolScreen()),
        );
        break;
        case 2:
        // Navegar a la pantalla de usuarios (aquí puedes implementar la navegación según tus necesidades)
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        break;
    }
  }
}