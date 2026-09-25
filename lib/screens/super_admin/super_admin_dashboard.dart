import 'package:flutter/material.dart';
import '../login_screen.dart';
import 'persetujuan_akun_screen.dart';
import 'kelola_artikel_screen.dart';
import 'kelola_voucher_screen.dart';

class SuperAdminDashboard extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const SuperAdminDashboard({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF11522E);
    final namaUser = userData?['nama'] ?? userData?['username'] ?? 'Super Admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Super Admin'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selamat Datang, $namaUser!', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Akses Utama Sistem (Super Admin)', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Kontrol Sistem Utama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              // PERBAIKAN: Hapus kata kunci 'const' sebelum nama class layar
              _buildMenuCard(context, Icons.how_to_reg, 'Persetujuan Akun', Colors.deepOrange, PersetujuanAkunScreen()),
              _buildMenuCard(context, Icons.article, 'Kelola Artikel Edukasi', Colors.blueAccent, KelolaArtikelScreen()),
              _buildMenuCard(context, Icons.card_giftcard, 'Kelola Voucher/Poin', Colors.purple, KelolaVoucherScreen()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title, Color color, Widget target) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
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