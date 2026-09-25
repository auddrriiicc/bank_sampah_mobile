import 'package:flutter/material.dart';

class TiketSampahScreen extends StatelessWidget {
  const TiketSampahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tiket Setor Sampah'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tiket Baru Berhasil Dibuat!')));
              },
              icon: const Icon(Icons.add),
              label: const Text('Buat Tiket Setor Baru'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Tunjukkan QR Code ini ke petugas:'),
                    const SizedBox(height: 12),
                    Icon(Icons.qr_code_2, size: 180, color: Colors.grey.shade800),
                    const Text('Kode Tiket: TKT-2026-00912', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}