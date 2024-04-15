import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewsDataScreen extends StatelessWidget {
  const ViewsDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes por Piscina'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('reportes').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          Map<String, List<Map<String, dynamic>>> piscinasReportes = {};
          snapshot.data?.docs.forEach((doc) {
            piscinasReportes[doc.id] = List<Map<String, dynamic>>.from(doc['reportes']);
          });

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: piscinasReportes.length,
              itemBuilder: (context, index) {
                String piscina = piscinasReportes.keys.elementAt(index);
                List<Map<String, dynamic>> reportes = piscinasReportes[piscina] ?? [];

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
                        Map<String, dynamic> reporte = reportes[index];
                        return ReportCard(
                          key: ValueKey(index), 
                          title: reporte['title'] ?? '', 
                          date: reporte['date'] != null ? DateFormat('yyyy-MM-dd').format(reporte['date'].toDate()) : '', 
                          time: reporte['time'] ?? '', 
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  const ReportCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
  }) : super(key: key);

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
