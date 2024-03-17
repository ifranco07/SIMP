import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Smart Pool'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/POOL.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Center(
                  child: Text(
                    'Bienvenido a Tu Piscina',
                    style: AppTheme.lightTheme.textTheme.headlineLarge,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/LoginScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
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
    );
  }
}
