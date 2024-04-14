import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simp/Theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white, // Color de fondo blanco
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/POOL.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(
                            'Bienvenido a Tu Piscina',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: GoogleFonts.bungee().fontFamily,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/LoginScreen');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 173, 214, 248),
                            textStyle: GoogleFonts.alatsi(
                              fontSize: 20,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                          child: const Text('Iniciar sesión'),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/RegisterScreen');
                          },
                          child: const Text(
                            '¿No tienes cuenta? Regístrate',
                            style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}