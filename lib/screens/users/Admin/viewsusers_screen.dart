import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simp/screens/users/Admin/registerusers_screen.dart';
import 'package:simp/Theme/app_theme.dart';
import 'edituser_screen.dart'; // Importa la pantalla EditUserScreen

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class ViewsUsersScreen extends StatefulWidget {
  final List<User> userList;

  const ViewsUsersScreen({super.key, required this.userList});

  @override
  _ViewsUsersScreenState createState() => _ViewsUsersScreenState();
}

class _ViewsUsersScreenState extends State<ViewsUsersScreen> {
  List<User> filteredUserList = [];

  @override
  void initState() {
    super.initState();
    filteredUserList = List.from(widget.userList); // Copiar la lista para evitar mutabilidad
  }

  @override
  Widget build(BuildContext context) {
    // Copiar y ordenar la lista
    List<User> sortedUserList = List.from(widget.userList);
    sortedUserList.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuarios',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: UserSearchDelegate(widget.userList));
            },
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Ajusta el número de usuarios por fila
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 2 / 3, // Ajusta el ancho y el largo de cada usuario
          ),
          itemCount: filteredUserList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditUserScreen(user: filteredUserList[index])),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredUserList[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        filteredUserList[index].email,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await Navigator.push<User?>(
            context,
            MaterialPageRoute(builder: (context) => const RegisterUsersScreen()),
          );

          if (newUser != null) {
            setState(() {
              widget.userList.add(newUser);
              filteredUserList.add(newUser); // Actualizar la lista filtrada
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserSearchDelegate extends SearchDelegate<String> {
  final List<User> userList;

  UserSearchDelegate(this.userList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.black),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<User> searchResults =
        userList.where((user) => user.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].name),
          subtitle: Text(searchResults[index].email),
          onTap: () {
            close(context, searchResults[index].name);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<User> suggestionList = userList
        .where((user) => user.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].name),
          subtitle: Text(suggestionList[index].email),
          onTap: () {
            close(context, suggestionList[index].name);
          },
        );
      },
    );
  }
}
