import 'package:flutter/material.dart';
import 'package:simp/screens/users/Admin/adminhome_screen.dart';

class DataPoolScreen extends StatefulWidget {
  const DataPoolScreen({Key? key}) : super(key: key);

  @override
  _DataPoolScreenState createState() => _DataPoolScreenState();
}

class _DataPoolScreenState extends State<DataPoolScreen> {
  int _selectedIndex = 0;

  final List<IconData> _navIcons = [
    Icons.home,
    Icons.wallet,
    Icons.person,
  ];

  final List<String> _navTitle = [
    "Home",
    "Wallet",
    "Account",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de la Piscina'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            _buildDataCard(
              title: 'Nivel de Sólidos',
              data: '80%',
              color: Colors.blue,
            ),
            _buildDataCard(
              title: 'pH',
              data: '7.2',
              color: Colors.green,
            ),
            _buildDataCard(
              title: 'Temperatura del Agua',
              data: '28°C',
              color: Colors.orange,
            ),
            _buildDataCard(
              title: 'Control de Luces',
              data: '',
              color: Colors.red,
              child: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            _buildDataCard(
              title: '2 switch',
              data: '',
              color: Colors.red,
              child: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
            _buildDataCard(
              title: 'Luz Automatica',
              data: '',
              color: Colors.red,
              child: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildDataCard({
    required String title,
    required String data,
    required Color color,
    Widget? child,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            if (child != null)
              child
            else
              Text(
                data,
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
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
        children: List.generate(
          _navIcons.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _navIcons[index],
                  color: _selectedIndex == index ? Colors.blue : Colors.grey,
                ),
                Text(
                  _navTitle[index],
                  style: TextStyle(
                    color: _selectedIndex == index ? Colors.blue : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
