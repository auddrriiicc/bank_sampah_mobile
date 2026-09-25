import 'package:flutter/material.dart';
import '../login_screen.dart';
import 'tiket_sampah_screen.dart';
import 'tiket_poin_screen.dart';
import 'edukasi_screen.dart';
import 'riwayat_transaksi_screen.dart';

class MasyarakatDashboard extends StatelessWidget {
  final Map<String, dynamic>? userData; // Tambahkan variabel ini

  const MasyarakatDashboard({super.key, this.userData}); // Tambahkan ini

  // ... isi widget lainnya

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF11522E);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Masyarakat'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: const Color(0xFFE8F5E9),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Saldo Poin', style: TextStyle(color: Colors.black54)),
                      Text('250 Poin', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Sampah', style: TextStyle(color: Colors.black54)),
                      Text('18.5 Kg', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Menu Utama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildCard(context, Icons.confirmation_number_outlined, 'Tiket Sampah', Colors.green, const TiketSampahScreen()),
              _buildCard(context, Icons.card_giftcard, 'Tiket Poin', Colors.orange, const TiketPoinScreen()),
              _buildCard(context, Icons.menu_book_outlined, 'Edukasi', Colors.blue, const EdukasiScreen()),
              _buildCard(context, Icons.history, 'Riwayat Transaksi', Colors.purple, const RiwayatTransaksiScreen()),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, Color color, Widget target) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      child: Container(
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.3))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}