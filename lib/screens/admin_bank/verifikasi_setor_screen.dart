import 'package:flutter/material.dart';

class VerifikasiSetorScreen extends StatelessWidget {
  const VerifikasiSetorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifikasi Setor Sampah'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code, color: Colors.teal, size: 32),
              title: const Text('Tiket #TKT-2026-00912'),
              subtitle: const Text('Nasabah: Ahmad | Sampah: Plastik'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Setoran Berhasil Diverifikasi!')));
                },
                child: const Text('Proses'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}