import 'package:flutter/material.dart';
import 'package:simp/Theme/app_theme.dart';
import 'package:simp/screens/users/Admin/viewsusers_screen.dart';
import 'package:simp/screens/users/Admin/viewspiscinas_screen.dart';
import 'package:simp/screens/users/Admin/viewsdata_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Administrador'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Usuarios',
              style: AppTheme.lightTheme.textTheme.headlineLarge,
            ),
            subtitle: Text(
              'Gestionar usuarios',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            leading: IconTheme(
              data: AppTheme.lightTheme.iconTheme,
              child: const Icon(Icons.people),
            ),
            trailing: IconTheme(
              data: AppTheme.lightTheme.iconTheme,
              child: const Icon(Icons.arrow_circle_right_rounded),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewsUsersScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              'Piscinas',
              style: AppTheme.lightTheme.textTheme.headlineLarge,
            ),
            subtitle: Text(
              'Gestionar piscinas',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            leading: IconTheme(
              data: AppTheme.lightTheme.iconTheme,
              child: const Icon(Icons.pool),
            ),
            trailing: IconTheme(
              data: AppTheme.lightTheme.iconTheme,
              child: const Icon(Icons.arrow_circle_right_rounded),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewPiscinasScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              'Reportes',
              style: AppTheme.lightTheme.textTheme.headlineLarge,
            ),
            subtitle: Text(
              'Ver reportes',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            leading: IconTheme(
              data: AppTheme.lightTheme.iconTheme,
              child: const Icon(Icons.receipt_long),
            ),
            trailing: IconTheme(
              data: AppTheme.lightTheme.iconTheme,
              child: const Icon(Icons.arrow_circle_right_rounded),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewsDataScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
