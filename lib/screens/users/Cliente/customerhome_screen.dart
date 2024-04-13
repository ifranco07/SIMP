import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
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
    Icons.control_point,
  ];

  final List<String> _navTitle = [
    "Reportes",
    "Datos",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Hace que el contenido del Scaffold se extienda detrás de la barra de la AppBar
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
            alignment: Alignment
                .center, // Alinear la imagen al centro vertical y horizontalmente
          ),
          // Contenido sobre la imagen de fondo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido ${widget.clienteName}', // Mostrar el nombre del administrador
                  style: AppTheme.lightTheme.textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildNavBar(),
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
      // Agrega casos adicionales aquí para cada ícono de navegación
    }
  }
}
