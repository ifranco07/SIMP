import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Colors.transparent, 
          elevation: 0, 
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.transparent, 
                  Colors.black.withOpacity(0.001), 
                ],
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0), // Padding para el contenido del flexibleSpace
            child: Image.asset(
              'lib/assets/images/Logo.png', // Ruta de la imagen de tu logo
              fit: BoxFit.contain,
              height: 100, 
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('lib/assets/images/POOL.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 70, 200, 243).withOpacity(0.25),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Bienvenido a Tu Piscina',
                    textAlign: TextAlign.center,
                    style: AppTheme.lightTheme.textTheme.headlineLarge,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginScreen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    textStyle: AppTheme.lightTheme.textTheme.headlineMedium,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Text('Iniciar sesión'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/RegisterScreen');
                  },
                  child: const Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
