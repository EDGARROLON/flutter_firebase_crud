import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> agregarUsuario(String nNombre, String nEmail, String nCuenta) async {
  try {
    await db.collection('usuarios').add({
      'nombre': nNombre,
      'email': nEmail,
      'nocuenta': nCuenta,
    });
    print('Usuario agregado correctamente');
  } catch (e) {
    print('Error al agregar usuario: $e');
  }
}