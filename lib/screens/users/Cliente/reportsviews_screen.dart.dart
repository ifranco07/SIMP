import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewsreportsScreen extends StatefulWidget {
  const ViewsreportsScreen({super.key});

  @override
  _ViewsreportsScreenState createState() => _ViewsreportsScreenState();
}

class _ViewsreportsScreenState extends State<ViewsreportsScreen> {
  late CollectionReference _reportesCollection;

  @override
  void initState() {
    super.initState();
    _reportesCollection = FirebaseFirestore.instance.collection('reportes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reportes por Piscina',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _reportesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          Map<String, List<Map<String, dynamic>>> piscinasReportes = {};
          snapshot.data?.docs.forEach((doc) {
            piscinasReportes[doc.id] = List<Map<String, dynamic>>.from(doc['reportes']);
          });

          return ListView.builder(
            itemCount: piscinasReportes.length,
            itemBuilder: (context, index) {
              String piscina = piscinasReportes.keys.elementAt(index);
              List<Map<String, dynamic>> reportes = piscinasReportes[piscina] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$piscina:',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reportes.length,
                      itemBuilder: (context, index) {
                        final reporte = reportes[index];
                        return ListTile(
                          title: Text(reporte['title'] ?? ''),
                          subtitle: Text('${DateFormat('yyyy-MM-dd hh:mm').format(reporte['date'].toDate())}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _eliminarReporte(docId: piscina, reporteId: reporte['id']);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _eliminarReporte({required String docId, required String reporteId}) async {
    try {
      await _reportesCollection.doc(docId).update({
        'reportes': FieldValue.arrayRemove([reporteId]),
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reporte eliminado')));
    } catch (e) {
      print('Error al eliminar el reporte: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al eliminar el reporte')));
    }
  }
}
