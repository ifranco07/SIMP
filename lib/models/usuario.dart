import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  final String nombre;
  final String correo;
  final String contrasena;
  final bool rol; // true: admin, false: usuario
  final String uid; // ID usuario único de Firebase Auth

  Usuario({
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.rol,
    required this.uid,
  });

  // Crear usuario para Auth y Firestore
  Future<void> crearUsuario() async {
    // Auth
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: correo, password: contrasena);
  }
}