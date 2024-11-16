import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot> getUsuarios() {
    return FirebaseFirestore.instance.collection('usuarios').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD with Firebase'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getUsuarios(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Algo salió mal'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: ((context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              
              final email = data['email']?.toString() ?? 'Sin email';
              final nocuenta = data['nocuenta']?.toString() ?? 'Sin cuenta';
              final nombre = data['nombre']?.toString() ?? 'Sin nombre';
              
              return ListTile(
                title: Text(nombre),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: $email'),
                    Text('No. Cuenta: $nocuenta'),
                  ],
                ),
                leading: CircleAvatar(
                  child: Text(nombre.isNotEmpty ? nombre[0] : '?'),
                ),
              );
            }),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}