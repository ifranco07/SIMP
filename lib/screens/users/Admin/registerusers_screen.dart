import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simp/Theme/app_theme.dart';
import 'package:simp/screens/users/Admin/viewsusers_screen.dart' as admin; // Alias para el import de viewsusers_screen.dart

class RegisterUsersScreen extends StatefulWidget {
  final Function(admin.User)? onUserRegistered; // Usando el tipo de User desde el alias admin

  const RegisterUsersScreen({super.key, this.onUserRegistered});

  @override
  _RegisterUsersScreenState createState() => _RegisterUsersScreenState();
}

class _RegisterUsersScreenState extends State<RegisterUsersScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedUserRole;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Usuarios',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(color: AppTheme.primaryColor),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          color: Colors.white.withOpacity(0.8),
          elevation: 8,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(_nameController, 'Nombre'),
                const SizedBox(height: 20),
                _buildTextField(_emailController, 'Correo electrónico'),
                const SizedBox(height: 20),
                _buildDropdownButtonFormField(
                  ['Cliente'],
                  'Rol',
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  _obscurePassword,
                  () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  _obscureConfirmPassword,
                  () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      _registerUser(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Registrar',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
      ),
    );
  }

  Widget _buildDropdownButtonFormField(List<String> items, String labelText) {
    return DropdownButtonFormField<String>(
      value: _selectedUserRole,
      onChanged: (newValue) {
        setState(() {
          _selectedUserRole = newValue;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    bool obscurePassword,
    VoidCallback togglePasswordVisibility,
    bool obscureConfirmPassword,
    VoidCallback toggleConfirmPasswordVisibility,
  ) {
    return Column(
      children: [
        TextFormField(
          obscureText: obscurePassword,
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppTheme.primaryColor),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off),
              onPressed: togglePasswordVisibility,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: 'Confirmar Contraseña',
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppTheme.primaryColor),
            ),
            suffixIcon: IconButton(
              icon: Icon(obscureConfirmPassword
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: toggleConfirmPasswordVisibility,
            ),
          ),
        ),
      ],
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
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                  size: 28,
                ),
                Text(
                  "Regresar",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para validar los campos de entrada
  bool _validateInputs() {
    final isValid = _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _selectedUserRole != null &&
        _passwordController.text.isNotEmpty;
    if (!isValid) {
      _showErrorAlert('Por favor, completa todos los campos correctamente');
    }
    return isValid;
  }

  // Método para mostrar un cuadro de diálogo de error
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

  // Método para registrar el usuario
  void _registerUser(BuildContext context) async {
    try {
      // Crear un usuario en Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Agregar el usuario a Firestore
      await FirebaseFirestore.instance.collection(_selectedUserRole == 'Administrador' ? 'Administrador' : 'Clientes').doc(userCredential.user!.uid).set({
        'nombre': _nameController.text,
        'email': _emailController.text,
        'rol': _selectedUserRole,
      });

      // Mostrar mensaje de éxito
      _showSuccessAlert('Su cuenta ha sido registrada con éxito');
    } on FirebaseAuthException catch (e) {
      print('Error al registrar el usuario en Firebase: ${e.message}');
      // Mostrar mensaje de error si ocurre algún problema
      _showErrorAlert('Ocurrió un error al registrar su cuenta: ${e.message}');
    }
  }

  // Método para mostrar un cuadro de diálogo de éxito
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
                // Regresar el nuevo usuario registrado a la pantalla anterior
                if (widget.onUserRegistered != null) {
                  widget.onUserRegistered!(admin.User(name: _nameController.text, email: _emailController.text, id: '')); // Usando el tipo User desde el alias admin
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
