import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
