import 'package:flutter/material.dart';

class KelolaNasabahScreen extends StatelessWidget {
  const KelolaNasabahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Nasabah'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.indigo, child: Icon(Icons.person, color: Colors.white)),
              title: Text('Ahmad Budi'),
              subtitle: Text('NIK: 167109210001 | Poin: 250'),
            ),
          ),
        ],
      ),
    );
  }
}