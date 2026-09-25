import 'package:flutter/material.dart';

class RiwayatTransaksiScreen extends StatelessWidget {
  const RiwayatTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(child: ListTile(title: Text('Setor Botol Plastik'), subtitle: Text('2.5 Kg'), trailing: Text('+25 Poin', style: TextStyle(color: Colors.green)))),
        ],
      ),
    );
  }
}