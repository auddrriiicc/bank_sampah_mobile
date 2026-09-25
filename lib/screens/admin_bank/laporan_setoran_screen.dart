import 'package:flutter/material.dart';

class LaporanSetoranScreen extends StatelessWidget {
  const LaporanSetoranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Setoran'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(
            child: ListTile(
              title: Text('Total Terkumpul Bulan Ini'),
              subtitle: Text('Botol Plastik: 120 Kg | Kardus: 85 Kg'),
            ),
          ),
        ],
      ),
    );
  }
}