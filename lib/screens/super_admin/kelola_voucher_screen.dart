import 'package:flutter/material.dart';

class KelolaVoucherScreen extends StatelessWidget {
  const KelolaVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Voucher Poin'), backgroundColor: const Color(0xFF11522E), foregroundColor: Colors.white),
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
              leading: Icon(Icons.card_giftcard, color: Colors.purple),
              title: Text('Voucher Minyak Goreng 1L'),
              subtitle: Text('Harga Poin: 250'),
            ),
          ),
        ],
      ),
    );
  }
}