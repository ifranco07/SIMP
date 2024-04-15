import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class DataPoolScreen extends StatefulWidget {
  const DataPoolScreen({Key? key}) : super(key: key);

  @override
  _DataPoolScreenState createState() => _DataPoolScreenState();
}

class _DataPoolScreenState extends State<DataPoolScreen> {
  int _selectedIndex = 0;

  final List<IconData> _navIcons = [
    Icons.home,
    Icons.document_scanner,
  ];

  final List<String> _navTitle = [
    "Home",
    "Reportes",
  ];

  late DatabaseReference _databaseReference;
  late String _temperature = '';
  late String _pH = '';
  late String _lightControl = '';
  late String _solidLevel = '';
  late bool _manualLightControl = false;
  late bool _manualSwitch2 = false;
  late bool _automaticLightControl = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    _databaseReference = FirebaseDatabase.instance.reference();
    _databaseReference.onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        _temperature = (snapshot.value as Map<dynamic, dynamic>?)?['temperature']?.toString() ?? '';
        _pH = (snapshot.value as Map<dynamic, dynamic>?)?['ph']?.toString() ?? '';
        _lightControl = (snapshot.value as Map<dynamic, dynamic>?)?['light_control']?.toString() ?? '';
        _solidLevel = (snapshot.value as Map<dynamic, dynamic>?)?['solid_level']?.toString() ?? '';
        _manualLightControl = (snapshot.value as Map<dynamic, dynamic>?)?['manual_light_control'] ?? false;
        _manualSwitch2 = (snapshot.value as Map<dynamic, dynamic>?)?['manual_switch_2'] ?? false;
        _automaticLightControl = (snapshot.value as Map<dynamic, dynamic>?)?['automatic_light_control'] ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Control de piscina',
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 29,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
              title: 'Temperatura del Agua',
              data: _temperature,
              color: Colors.orange,
              icon: Icons.thermostat,
            ),
            _buildDataCard(
              title: 'PH',
              data: _pH,
              color: Colors.green,
              icon: Icons.waves,
            ),
            _buildDataCard(
              title: 'Control de luz',
              data: _lightControl,
              color: Colors.red,
              icon: Icons.lightbulb_outline,
            ),
            _buildDataCard(
              title: 'Nivel de Sólidos',
              data: _solidLevel,
              color: Colors.blue,
              icon: Icons.opacity,
            ),
            _buildDataCard(
              title: 'Control de luz manual',
              data: _manualLightControl ? 'Encendido' : 'Apagado',
              color: Colors.red,
              icon: Icons.lightbulb_outline,
              child: Switch(
                value: _manualLightControl,
                onChanged: (value) {
                  setState(() {
                    _manualLightControl = value;
                    _databaseReference.update({'manual_light_control': value});
                  });
                },
              ),
            ),
            _buildDataCard(
              title: 'Control del switch 2 manual',
              data: _manualSwitch2 ? 'Encendido' : 'Apagado',
              color: Colors.red,
              icon: Icons.lightbulb_outline,
              child: Switch(
                value: _manualSwitch2,
                onChanged: (value) {
                  setState(() {
                    _manualSwitch2 = value;
                    _databaseReference.update({'manual_switch_2': value});
                  });
                },
              ),
            ),
            _buildDataCard(
              title: 'Control de luz automático',
              data: _automaticLightControl ? 'Encendido' : 'Apagado',
              color: Colors.red,
              icon: Icons.lightbulb_outline,
              child: Switch(
                value: _automaticLightControl,
                onChanged: (value) {
                  setState(() {
                    _automaticLightControl = value;
                    _databaseReference.update({'automatic_light_control': value});
                  });
                },
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
    required IconData icon,
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
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 10),
            if (child != null)
              child
            else
              Text(data, style: TextStyle(fontSize: 18, color: Colors.black)),
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
