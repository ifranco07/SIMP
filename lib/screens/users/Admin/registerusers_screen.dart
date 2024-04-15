import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simp/Theme/app_theme.dart';
import 'package:simp/screens/users/Admin/viewsusers_screen.dart';

class RegisterUsersScreen extends StatefulWidget {
  const RegisterUsersScreen({super.key});

  @override
  _RegisterUsersScreenState createState() => _RegisterUsersScreenState();
}

class _RegisterUsersScreenState extends State<RegisterUsersScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _selectedUserRole;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _registerUser() async {
    try {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Las contraseñas no coinciden'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Guardar otros detalles del usuario en Firestore, por ejemplo el nombre
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': _nameController.text,
        'email': _emailController.text,
        'role': _selectedUserRole,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario registrado con éxito'),
          duration: Duration(seconds: 2),
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() {
        _selectedUserRole = null;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar el usuario: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

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
                  onPressed: _registerUser,
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
          controller: _confirmPasswordController,
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
}
