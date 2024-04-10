import 'package:flutter/material.dart';

class ViewsreportsScreen extends StatelessWidget {
  const ViewsreportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ejemplo de mapa que relaciona piscinas con reportes de limpieza
    Map<String, List<Map<String, String>>> piscinasReportes = {
      'Piscina 1': [
        {'title': 'Reporte 1', 'date': '14 de noviembre de 2023', 'time': '10:00 AM'},
        {'title': 'Reporte 2', 'date': '15 de noviembre de 2023', 'time': '11:00 AM'},
        {'title': 'Reporte 3', 'date': '16 de noviembre de 2023', 'time': '12:00 PM'},
      ],
      'Piscina 2': [
        {'title': 'Reporte 4', 'date': '17 de noviembre de 2023', 'time': '1:00 PM'},
        {'title': 'Reporte 5', 'date': '18 de noviembre de 2023', 'time': '2:00 PM'},
      ],
      'Piscina 3': [
        {'title': 'Reporte 6', 'date': '19 de noviembre de 2023', 'time': '3:00 PM'},
      ],
      // Agrega más piscinas y sus reportes según sea necesario
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
                Text(
                  '$piscina:',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reportes.length,
                  itemBuilder: (context, index) {
                    Map<String, String> reporte = reportes[index];
                    return ReportCard(
                      key: ValueKey(index), // Agrega un ValueKey para evitar errores de duplicación de claves
                      title: reporte['title'] ?? '', // Maneja valores nulos proporcionando un valor predeterminado
                      date: reporte['date'] ?? '', // Maneja valores nulos proporcionando un valor predeterminado
                      time: reporte['time'] ?? '', // Maneja valores nulos proporcionando un valor predeterminado
                    );
                  },
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

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key, // Agrega un parámetro de clave
    this.title = '', // Proporciona valores predeterminados y permite valores nulos
    this.date = '', // Proporciona valores predeterminados y permite valores nulos
    this.time = '', // Proporciona valores predeterminados y permite valores nulos
  }); // Llama al constructor super con la clave

  final String title;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
