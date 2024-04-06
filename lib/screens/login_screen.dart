import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'users/Admin/adminhome_screen.dart';
import 'resetpassword_screen.dart';

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
          alignment: Alignment.topLeft,
          child: Image.asset(
            'lib/assets/images/Logo.png',
            fit: BoxFit.contain,
            height: 100,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'lib/assets/images/textura-agua-piscina.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 1.0,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.01),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildRoundedTextField(_emailController, 'Correo/Usuario'),
                            const SizedBox(height: 16),
                            _buildRoundedPasswordField(_passwordController, 'Contraseña'),
                            ElevatedButton(
                              onPressed: () {
                                if (_validateInputs(context)) {
                                  _loginUser(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                              child: const Text('Iniciar Sesión'),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'O',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                'lib/assets/images/Google.png',
                                width: 60,
                                height: 60,
                              ),
                            ),
                            const SizedBox(height: 8),
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedPasswordField(TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                // Cambia el estado de visibilidad de la contraseña
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

  void _loginUser(BuildContext context) {
    // Aquí irá la lógica para validar el inicio de sesión y redirigir al usuario según su rol.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen(adminName: '',)),
    );
  }
}
