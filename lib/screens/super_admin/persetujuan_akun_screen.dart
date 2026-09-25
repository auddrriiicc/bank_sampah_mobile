import 'package:flutter/material.dart';

class PersetujuanAkunScreen extends StatelessWidget {
  const PersetujuanAkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persetujuan Pendaftaran'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              title: const Text('Siti Aminah'),
              subtitle: const Text('Role: Admin Bank Sampah | Status: Menunggu'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.cancel, color: Colors.red), onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}