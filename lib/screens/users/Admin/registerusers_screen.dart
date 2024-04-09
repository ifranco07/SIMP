import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simp/screens/users/Admin/viewsusers_screen.dart';
import 'package:simp/Theme/app_theme.dart';

class User {
  final String name;
  final String email;
  final String? profileImage;

  User({required this.name, required this.email, this.profileImage});
}

class RegisterUsersScreen extends StatefulWidget {
  const RegisterUsersScreen({super.key});

  @override
  State<RegisterUsersScreen> createState() => _RegisterUsersScreenState();
}

class _RegisterUsersScreenState extends State<RegisterUsersScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _selectedUserRole;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Registro de Usuarios',
            style: TextStyle(color: AppTheme.primaryColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/textura-agua-piscina.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
                    _buildRoundedTextField(_nameController, 'Nombre'),
                    const SizedBox(height: 12),
                    _buildRoundedTextField(_lastNameController, 'Apellido'),
                    const SizedBox(height: 12),
                    _buildRoundedTextField(_emailController, 'Correo electrónico'),
                    const SizedBox(height: 12),
                    _buildRoundedDropdownButtonFormField(
                        ['Cliente'], 'Rol'),
                    const SizedBox(height: 12),
                    _buildRoundedPasswordField(_passwordController,
                        'Contraseña', _obscurePassword, () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    }),
                    const SizedBox(height: 12),
                    _buildRoundedPasswordField(_confirmPasswordController,
                        'Confirmar Contraseña', _obscureConfirmPassword, () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    }),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          final newUser = User(
                            name: _nameController.text,
                            email: _emailController.text,
                            profileImage: _selectedImage?.path,
                          );
                          Navigator.pop(context, newUser);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppTheme.primaryColor,
                        ),
                        child: const Text('Registrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextField(
      TextEditingController controller, String labelText,
      {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedDropdownButtonFormField(
      List<String> items, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: DropdownButtonFormField<String>(
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
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        selectedItemBuilder: (BuildContext context) {
          return items.map<Widget>((String item) {
            return Container(
              color: Colors.white.withOpacity(0.7),
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildRoundedPasswordField(TextEditingController controller,
      String labelText, bool obscureText, Function() onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
