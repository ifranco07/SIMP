import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'users/Admin/adminhome_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
      body: Stack(
        children: [
          Image.asset(
            'lib/assets/images/textura-agua-piscina.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 1.0,
              child: Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15), 
                      _buildRoundedTextField(_firstNameController, 'Nombre'),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(_lastNameController, 'Apellido'),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(_usernameController, 'Nombre de usuario'),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(_emailPhoneController, 'Correo/Teléfono'),
                      const SizedBox(height: 16),
                      _buildRoundedPasswordField(_passwordController, 'Contraseña', _obscurePassword, () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      }),
                      const SizedBox(height: 16),
                      _buildRoundedPasswordField(_confirmPasswordController, 'Confirmar Contraseña', _obscureConfirmPassword, () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      }),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() {
                                _acceptTerms = value!;
                              });
                            },
                          ),
                          Text(
                            'He leído y acepto los términos y condiciones',
                            style: TextStyle(
                              color: _acceptTerms ? Colors.black : Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Implementar la lógica para mostrar los términos y condiciones
                        },
                        child: const Text(
                          'Ver Política de Términos y Condiciones',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_validateInputs()) {
                            _registerUser(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        child: const Text('Registrarse'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 50.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: AppTheme.secondaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedPasswordField(TextEditingController controller, String labelText, bool obscureText, Function() onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: AppTheme.secondaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    final isValid = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _emailPhoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _acceptTerms;
    if (!isValid) {
      _showErrorAlert(
          'Por favor, completa todos los campos y acepta los términos y condiciones');
    }
    return isValid;
  }

  void _registerUser(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen(adminName: '',)),
    );
    _showSuccessAlert('Su cuenta ha sido registrada con éxito');
  }

  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro exitoso'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de registro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
