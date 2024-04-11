import 'package:flutter/material.dart';
import 'package:simp/screens/users/Admin/viewsreports_screen.dart';
import 'package:simp/screens/users/Cliente/addresports_screen.dart';
class ViewsreportsScreen extends StatelessWidget {
  const ViewsreportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> piscinasReportes = {
      'Piscina 1': [
        {'title': 'Reporte 1', 'date': '14 de noviembre de 2023', 'time': '10:00 AM'},
        {'title': 'Reporte 2', 'date': '15 de noviembre de 2023', 'time': '11:00 AM'},
        {'title': 'Reporte 3', 'date': '16 de noviembre de 2023', 'time': '12:00 PM'},
        // Agrega más reportes según sea necesario
      ],
      'Piscina 2': [
        {'title': 'Reporte 4', 'date': '17 de noviembre de 2023', 'time': '1:00 PM'},
        {'title': 'Reporte 5', 'date': '18 de noviembre de 2023', 'time': '2:00 PM'},
        // Agrega más reportes según sea necesario
      ],
      'Piscina 3': [
        {'title': 'Reporte 6', 'date': '19 de noviembre de 2023', 'time': '3:00 PM'},
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes por Piscina'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: piscinasReportes.length,
          itemBuilder: (context, index) {
            String piscina = piscinasReportes.keys.elementAt(index);
            List<Map<String, String>> reportes = piscinasReportes[piscina] ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '$piscina:',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
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
    );
  }
}
