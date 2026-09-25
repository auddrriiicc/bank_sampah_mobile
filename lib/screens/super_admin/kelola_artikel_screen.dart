import 'package:flutter/material.dart';

class KelolaArtikelScreen extends StatelessWidget {
  const KelolaArtikelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Artikel Edukasi'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF11522E),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.description, color: Colors.blueAccent),
              title: Text('Panduan Memilah Sampah Plastik'),
              trailing: Icon(Icons.edit, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}