import 'package:flutter/material.dart';

class ViewsDataScreen extends StatelessWidget {
  const ViewsDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ejemplo de mapa que relaciona piscinas con reportes de limpieza
    Map<String, List<String>> piscinasReportes = {
      'Piscina 1': ['Reporte 1', 'Reporte 2', 'Reporte 3'],
      'Piscina 2': ['Reporte 4', 'Reporte 5'],
      'Piscina 3': ['Reporte 6'],
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
            List<String> reportes = piscinasReportes[piscina] ?? [];

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
                    return ListTile(
                      title: Text(reportes[index]),
                      // Aquí podrías mostrar el usuario al que le corresponde este reporte
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
