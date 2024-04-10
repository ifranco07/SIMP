import 'package:flutter/material.dart';
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
  String? _selectedUserRole;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro de Usuarios',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            _buildRoundedTextField(_nameController, 'Nombre'),
            const SizedBox(height: 12),
            _buildRoundedTextField(_emailController, 'Correo electrónico'),
            const SizedBox(height: 12),
            _buildRoundedDropdownButtonFormField(
              ['Cliente'],
              'Rol',
            ),
            const SizedBox(height: 12),
            _buildRoundedPasswordField(
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
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  final newUser = User(
                    name: _nameController.text,
                    email: _emailController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewsUsersScreen(
                        userList: [newUser],
                      ),
                    ),
                  );
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
    );
  }

  Widget _buildRoundedTextField(TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedDropdownButtonFormField(List<String> items, String labelText) {
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
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
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

  Widget _buildRoundedPasswordField(
    bool obscurePassword,
    VoidCallback togglePasswordVisibility,
    bool obscureConfirmPassword,
    VoidCallback toggleConfirmPasswordVisibility,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          TextFormField(
            obscureText: obscurePassword,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              suffixIcon: IconButton(
                icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: togglePasswordVisibility,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            obscureText: obscureConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Confirmar Contraseña',
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              suffixIcon: IconButton(
                icon: Icon(obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: toggleConfirmPasswordVisibility,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
