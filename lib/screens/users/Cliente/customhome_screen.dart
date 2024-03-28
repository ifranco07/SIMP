import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class CustomHomeScreen extends StatelessWidget {
  final String clienteName; // Nombre del cliente

  const CustomHomeScreen({Key? key, required this.clienteName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Pantalla de Cliente'),
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
          ),
        ),
        // Barra de navegación en el footer
        BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuración',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone),
              label: 'Contacto',
            ),
          ],
          selectedItemColor: AppTheme.primaryColor,
          onTap: (int index) {
            // Manejar la navegación aquí según el índice seleccionado
            switch (index) {
              case 0:
                // Aquí puedes navegar a la pantalla de configuración
                break;
              case 1:
                // Aquí puedes navegar a la pantalla de historial
                break;
              case 2:
                // Aquí puedes navegar a la pantalla de contacto
                break;
            }
          },
        ),
      ],
    );
  }
}
