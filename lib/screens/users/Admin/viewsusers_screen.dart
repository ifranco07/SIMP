import 'package:flutter/material.dart';
import 'package:simp/screens/users/Admin/adminhome_screen.dart';
import 'package:simp/screens/users/Admin/registerusers_screen.dart';
import 'edituser_screen.dart'; // Importa la pantalla EditUserScreen

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class ViewsUsersScreen extends StatefulWidget {
  final List<User> userList;

  const ViewsUsersScreen({Key? key, required this.userList}) : super(key: key);

  @override
  _ViewsUsersScreenState createState() => _ViewsUsersScreenState();
}

class _ViewsUsersScreenState extends State<ViewsUsersScreen> {
  List<User> filteredUserList = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredUserList =
        List.from(widget.userList); // Copiar la lista para evitar mutabilidad
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(60.0), // Agrega este radio
            bottomRight: Radius.circular(60.0), // Agrega este radio
          ),
        ),
        title: Text(
          'Usuarios',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: UserSearchDelegate(widget.userList, context),
              );
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
            childAspectRatio:
                2 / 3, // Ajusta el ancho y el largo de cada usuario
          ),
          itemCount: filteredUserList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditUserScreen(user: filteredUserList[index])),
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
                            .bodyText1
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        filteredUserList[index].email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
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
      bottomNavigationBar: _buildNavBar(),
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
              setState(() {
                _selectedIndex = 0;
              });
              _onItemTapped(0);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add, // Cambia el ícono a un ícono de agregar
                  color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                  size: 28,
                ),
                Text(
                  "Agregar Usuario", // Cambia el texto del botón
                  style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
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

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        // Navegar a la pantalla de agregar usuario
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterUsersScreen(),
          ),
        );
        break;
      // Otros casos de navegación
    }
  }
}

class UserSearchDelegate extends SearchDelegate<String> {
  final List<User> userList;
  final BuildContext context;

  UserSearchDelegate(this.userList, this.context);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
        fillColor: Colors.grey,
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
    final List<User> searchResults = userList
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
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
        .where(
            (user) => user.name.toLowerCase().startsWith(query.toLowerCase()))
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
