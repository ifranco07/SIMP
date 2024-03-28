import 'package:flutter/material.dart';
import 'package:simp/screens/users/Admin/registerusers_screen.dart';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class ViewsUsersScreen extends StatelessWidget {
  const ViewsUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Supongamos que userList es una lista de usuarios que proviene de algún lugar
    List<User> userList = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: Column(
        children: [
          Expanded(
            child: userList.isEmpty
                ? const Center(
                    child: Text('No hay usuarios registrados'),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(userList[index].name),
                          subtitle: Text(userList[index].email),
                        ),
                      );
                    },
                  ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterUsersScreen()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Agregar Usuario'),
          ),
        ],
      ),
    );
  }
}
