import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewsreportsScreen extends StatefulWidget {
  const ViewsreportsScreen({Key? key}) : super(key: key);

  @override
  _ViewsreportsScreenState createState() => _ViewsreportsScreenState();
}

class _ViewsreportsScreenState extends State<ViewsreportsScreen> {
  late CollectionReference reportesCollection;
  Map<String, List<Map<String, String>>> piscinasReportes = {};

  @override
  void initState() {
    super.initState();
    // Obtener referencia a la colección "reportes" en Firestore
    reportesCollection = FirebaseFirestore.instance.collection('reportes');
    // Cargar los reportes al iniciar la pantalla
    _loadReportes();
  }

  void _loadReportes() async {
    try {
      // Consultar todos los documentos de la colección "reportes"
      QuerySnapshot querySnapshot = await reportesCollection.get();

      // Iterar sobre los documentos y actualizar el mapa de reportes
      querySnapshot.docs.forEach((doc) {
        setState(() {
          piscinasReportes[doc.id] = List<Map<String, String>>.from(doc['reportes']);
        });
      });
    } catch (e) {
      print('Error al cargar los reportes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reportes por Piscina',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumen de Reportes',
              style: GoogleFonts.bebasNeue(
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: piscinasReportes.length,
                itemBuilder: (context, index) {
                  String piscina = piscinasReportes.keys.elementAt(index);
                  List<Map<String, String>> reportes =
                      piscinasReportes[piscina] ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$piscina:',
                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: reportes
                                .map((reporte) => ReportCard(
                                      key: ValueKey(reporte['title']),
                                      title: reporte['title'] ?? '',
                                      date: reporte['date'] ?? '',
                                      time: reporte['time'] ?? '',
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    int selectedIndex = 0;

    final List<IconData> navIcons = [
      Icons.home,
      Icons.add, // Icono para agregar reporte
    ];

    final List<String> navTitle = [
      "Home",
      "Agregar", // Título para agregar reporte
    ];

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
          navIcons.length,
          (index) => GestureDetector(
            onTap: () {
              // Aquí puedes manejar el cambio de página o cualquier otra acción según el índice seleccionado
              if (index == 1) {
                // Navegar a la pantalla para agregar reporte
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddReportsScreen()),
                );
              } else {
                selectedIndex = index;
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  navIcons[index],
                  color: selectedIndex == index ? Colors.blue : Colors.grey,
                ),
                Text(
                  navTitle[index],
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.blue : Colors.grey,
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

class ReportCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const ReportCard({
    required Key key,
    required this.title,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('$date - $time'),
    );
  }
}

class AddReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Reporte'),
      ),
      body: const Center(
        child: Text('Pantalla para agregar reporte'),
      ),
    );
  }
}
