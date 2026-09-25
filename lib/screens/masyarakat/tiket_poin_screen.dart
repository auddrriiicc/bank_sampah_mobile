import 'package:flutter/material.dart';

class TiketPoinScreen extends StatelessWidget {
  const TiketPoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tiket Tukar Poin'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(child: ListTile(leading: Icon(Icons.card_giftcard, color: Colors.orange), title: Text('Voucher Pulsa Rp 10.000'), subtitle: Text('100 Poin'))),
          Card(child: ListTile(leading: Icon(Icons.card_giftcard, color: Colors.orange), title: Text('Minyak Goreng 1 Liter'), subtitle: Text('250 Poin'))),
        ],
      ),
    );
  }
}