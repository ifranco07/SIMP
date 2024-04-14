import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewsreportsScreen extends StatelessWidget {
  const ViewsreportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> piscinasReportes = {
      'Piscina 1': [
        {
          'title': 'Reporte 1',
          'date': '14 de noviembre de 2023',
          'time': '10:00 AM'
        },
        {
          'title': 'Reporte 2',
          'date': '15 de noviembre de 2023',
          'time': '11:00 AM'
        },
        {
          'title': 'Reporte 3',
          'date': '16 de noviembre de 2023',
          'time': '12:00 PM'
        },
        // Agrega más reportes según sea necesario
      ],
      'Piscina 2': [
        {
          'title': 'Reporte 4',
          'date': '17 de noviembre de 2023',
          'time': '1:00 PM'
        },
        {
          'title': 'Reporte 5',
          'date': '18 de noviembre de 2023',
          'time': '2:00 PM'
        },
        // Agrega más reportes según sea necesario
      ],
      'Piscina 3': [
        {
          'title': 'Reporte 6',
          'date': '19 de noviembre de 2023',
          'time': '3:00 PM'
        },
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reportes por Piscina',
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 29, // Tamaño de la letra
            ),
          ),
        ),
        centerTitle: true, // Centrar el texto del AppBar
        backgroundColor: Colors.white, // Fondo blanco del AppBar
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
                        // Envuelve el Container con SingleChildScrollView
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
      Icons.play_arrow,
    ];

    final List<String> navTitle = [
      "Home",
      "Control",
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
              selectedIndex = index;
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
    super.key,
    required this.title,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('$date - $time'),
    );
  }
}