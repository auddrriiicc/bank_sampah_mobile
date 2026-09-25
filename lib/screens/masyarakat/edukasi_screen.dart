import 'package:flutter/material.dart';

class EdukasiScreen extends StatelessWidget {
  const EdukasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edukasi Sampah'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(child: ListTile(leading: Icon(Icons.eco, color: Colors.green), title: Text('Cara Memilah Sampah Organik'), subtitle: Text('Panduan pemilahan dari rumah...'))),
        ],
      ),
    );
  }
}