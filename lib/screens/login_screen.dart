import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simp/Theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simp/screens/users/Admin/adminhome_screen.dart';
import 'package:simp/screens/users/Cliente/customerhome_screen.dart';
import 'package:simp/screens/resetpassword_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
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
      ),
      body: Stack(
        children: [
          Image.asset(
            'lib/assets/images/fondopi.jpeg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Inicio de sesión',
                    style: GoogleFonts.londrinaSolid(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildRoundedTextField(
                    _emailController,
                    'Correo/Usuario',
                  ),
                  const SizedBox(height: 20),
                  _buildRoundedPasswordField(
                    _passwordController,
                    'Contraseña',
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_validateInputs(context)) {
                        _loginUser(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 86, 205, 235),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Iniciar Sesión',
                      style: GoogleFonts.alatsi(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'O',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'lib/assets/images/Google.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/ResetPasswordScreen');
                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextField(TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildRoundedPasswordField(TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: labelText,
           border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  bool _validateInputs(BuildContext context) {
    final isValid = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos'),
        ),
      );
    }
    return isValid;
  }
  void _loginUser(BuildContext context) async {
    try {
      bool isEmail = _emailController.text.contains('@');
      UserCredential userCredential;
      if (isEmail) {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        } else {
          final querySnapshot = await FirebaseFirestore.instance.collection('users').where('username', isEqualTo: _emailController.text.trim()).get();
          if (querySnapshot.docs.isNotEmpty) {
            final userDoc = querySnapshot.docs.first;
            final email = userDoc.data()['email'];
            userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: _passwordController.text.trim(),
            );
            }else {
              throw Exception('No se encontró ningún usuario con ese nombre de usuario');
            }
          }
          final userId = userCredential.user?.uid;
          if(userId != null) {
            final userRoleSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
            final userRole = userRoleSnapshot.data()?['role'];
            if (userRole == 'admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdminHomeScreen(adminName: '')),
              );
            }else if (userRole == 'Cliente') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CustomerHomeScreen(clienteName: '')),
              );
            }else {
              throw Exception('Rol de usuario no válido');
            }
          }else {
            throw Exception('Error al autenticar al usuario');
          }
      }catch (error) {
        print('Error de inicio de sesión: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error de inicio de sesión: $error'),
          ),
        );
      }
    }
}
