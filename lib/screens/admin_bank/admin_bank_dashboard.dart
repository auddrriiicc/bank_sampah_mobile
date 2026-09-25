import 'package:flutter/material.dart';
import '../login_screen.dart';
import 'verifikasi_setor_screen.dart';
import 'kelola_nasabah_screen.dart';
import 'laporan_setoran_screen.dart';

class AdminBankDashboard extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const AdminBankDashboard({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF11522E);
    final namaUser = userData?['nama'] ?? userData?['username'] ?? 'Admin Bank';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin Bank'),
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
            color: primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo, $namaUser!', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Role: Admin Bank Sampah', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Panel Operasional', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              // PERBAIKAN: Hapus kata 'const' sebelum nama layar
              _buildMenuCard(context, Icons.qr_code_scanner, 'Verifikasi Setoran', Colors.teal, VerifikasiSetorScreen()),
              _buildMenuCard(context, Icons.people, 'Data Nasabah', Colors.indigo, KelolaNasabahScreen()),
              _buildMenuCard(context, Icons.bar_chart, 'Laporan Setoran', Colors.amber.shade800, LaporanSetoranScreen()),
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