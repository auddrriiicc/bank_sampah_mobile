import 'package:flutter/material.dart';
import '../login_screen.dart';

class AdminBankDashboard extends StatefulWidget {
  const AdminBankDashboard({super.key});

  @override
  State<AdminBankDashboard> createState() => _AdminBankDashboardState();
}

class _AdminBankDashboardState extends State<AdminBankDashboard> {
  // Index sub-menu: 0 = Beranda, 1 = Tiket Sampah, 2 = Tiket Poin, 3 = Scan QR
  int _activeTabIndex = 0;

  // Warna Tema Utama Bank Sampah Sekanak
  static const Color primaryGreen = Color(0xFF0F5A2A);
  static const Color accentGreen = Color(0xFF16A34A);
  static const Color bgPage = Color(0xFFF3F7F4);
  static const Color bgCard = Color(0xFFE6EFE8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPage,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // Sub-Menu Navigation Bar (Beranda, Tiket Sampah, Tiket Poin, Scan QR)
          _buildSubMenuTabPills(),

          // Konten Utama Berdasarkan Sub-Menu yang Dipilih
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: _buildActiveSubMenuContent(),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // APPBAR UTAMA
  // ===========================================================================
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: primaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.recycling, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Bank Sampah Sekanak',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        // Lencana Notifikasi
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        // Tombol Logout
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.redAccent),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          ),
        ),
        // Avatar Inisial Profile Admin
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: primaryGreen,
            child: const Text(
              'BS',
              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // SUB-MENU NAVIGATION PILLS
  // ===========================================================================
  Widget _buildSubMenuTabPills() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildPillItem(0, 'Beranda', Icons.dashboard_outlined),
            _buildPillItem(1, 'Tiket Sampah', Icons.delete_outline),
            _buildPillItem(2, 'Tiket Poin', Icons.confirmation_number_outlined),
            _buildPillItem(3, 'Scan QR', Icons.qr_code_scanner),
          ],
        ),
      ),
    );
  }

  Widget _buildPillItem(int index, String label, IconData icon) {
    final bool isActive = _activeTabIndex == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () => setState(() => _activeTabIndex = index),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? primaryGreen : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: isActive ? Colors.white : Colors.black),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black87,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // ROUTER KONTEN Halaman SUB-MENU
  // ===========================================================================
  Widget _buildActiveSubMenuContent() {
    switch (_activeTabIndex) {
      case 0:
        return _buildBerandaView();
      case 1:
        return _buildTiketSampahView();
      case 2:
        return _buildTiketPoinView();
      case 3:
        return _buildScanQRView();
      default:
        return _buildBerandaView();
    }
  }

  // ---------------------------------------------------------------------------
  // SUB-MENU 1: BERANDA
  // ---------------------------------------------------------------------------
  Widget _buildBerandaView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dashboard Admin Bank Sampah',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const Text(
          'Kelola setoran dan penukaran poin sampah',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 14),

        // Grid 4 Kartu Statistik Ringkasan
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard('Total Tiket Setor', '2', Icons.inventory_2_outlined, const Color(0xFFE0F2FE), Colors.blue),
            _buildStatCard('Tiket Setor Pending', '0', Icons.access_time, const Color(0xFFFEF3C7), Colors.orange),
            _buildStatCard('Tiket Setor Selesai', '2', Icons.check_circle_outline, const Color(0xFFDCFCE7), Colors.green),
            _buildStatCard('Tiket Poin Pending', '0', Icons.stars_outlined, const Color(0xFFF3E8FF), Colors.purple),
          ],
        ),
        const SizedBox(height: 16),

        // Card Informasi Bank Sampah & Aksi Cepat
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: bgCard, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Informasi Bank Sampah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              const Text('Alamat: Jl. Hello World', style: TextStyle(fontSize: 12, color: Colors.black87)),
              const SizedBox(height: 2),
              const Text('Jam Operasional: Senin - Jum\'at, 08:00 - 12:00', style: TextStyle(fontSize: 12, color: Colors.black87)),
              const SizedBox(height: 2),
              const Text('No. Telepon: 083155219008', style: TextStyle(fontSize: 12, color: Colors.black87)),
              const SizedBox(height: 14),

              // Tombol Utama Scan QR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _activeTabIndex = 3),
                  icon: const Icon(Icons.qr_code_scanner, size: 18),
                  label: const Text('Scan QR Tiket'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Tombol Deposit & Voucher
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 16, color: primaryGreen),
                      label: const Text('Deposit', style: TextStyle(color: primaryGreen, fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.card_giftcard, size: 16, color: primaryGreen),
                      label: const Text('Voucher', style: TextStyle(color: primaryGreen, fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 14),

        // List Status Tiket Pending
        _buildPendingBox('Tiket Setor Pending'),
        const SizedBox(height: 10),
        _buildPendingBox('Tiket Poin Pending'),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SUB-MENU 2: TIKET SAMPAH
  // ---------------------------------------------------------------------------
  Widget _buildTiketSampahView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daftar Pengajuan Setoran Sampah', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text('Semua tiket deposit sampah dari masyarakat', style: TextStyle(fontSize: 11, color: Colors.black54)),
        const SizedBox(height: 12),

        // Ringkasan Status Mini
        Row(
          children: [
            Expanded(child: _buildMiniStatCard('Total Tiket', '2', Colors.black87)),
            Expanded(child: _buildMiniStatCard('Menunggu', '0', Colors.orange)),
            Expanded(child: _buildMiniStatCard('Selesai', '2', accentGreen)),
          ],
        ),
        const SizedBox(height: 14),

        // Item Kartu Tiket Sampah
        _buildTiketSampahItem('David Sean', '1671123456789516', '500 gram', '12 Sep 2026', 'Selesai'),
        _buildTiketSampahItem('Bagus Ananta Hidayatullah', '1671123456789515', '50,000 gram', '12 Sep 2026', 'Selesai'),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SUB-MENU 3: TIKET POIN
  // ---------------------------------------------------------------------------
  Widget _buildTiketPoinView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daftar Pengajuan Penukaran Voucher', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text('Semua tiket penukaran poin dari masyarakat', style: TextStyle(fontSize: 11, color: Colors.black54)),
        const SizedBox(height: 12),

        // Ringkasan Status Mini
        Row(
          children: [
            Expanded(child: _buildMiniStatCard('Total Tiket', '3', Colors.black87)),
            Expanded(child: _buildMiniStatCard('Menunggu', '0', Colors.orange)),
            Expanded(child: _buildMiniStatCard('Selesai', '1', accentGreen)),
          ],
        ),
        const SizedBox(height: 14),

        // Item Kartu Tiket Poin
        _buildTiketPoinItem('Bagus Ananta Hidayatullah', '1671123456789515', '500', '0 item', '12 Sep 2026', 'Selesai'),
        _buildTiketPoinItem('Bagus Ananta Hidayatullah', '1671123456789515', '500', '0 item', '12 Sep 2026', 'Dibatalkan'),
        _buildTiketPoinItem('Bagus Ananta Hidayatullah', '1671123456789515', '500', '0 item', '12 Sep 2026', 'Dibatalkan'),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SUB-MENU 4: SCAN QR
  // ---------------------------------------------------------------------------
  Widget _buildScanQRView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: bgCard, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const Icon(Icons.qr_code_scanner, size: 48, color: primaryGreen),
          const SizedBox(height: 8),
          const Text('Scan QR Tiket', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text('Arahkan kamera HP ke QR code tiket warga', style: TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
          const SizedBox(height: 16),

          // Area Kamera
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryGreen.withOpacity(0.5), width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt_outlined, size: 48, color: Colors.black45),
                  SizedBox(height: 8),
                  Text('Area Pemindaian QR', style: TextStyle(color: Colors.black45, fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Pesan Status Scan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Status Kamera: Siap Memindai',
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 14),

          // Tombol Kontrol Kamera
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('Mulai Scan', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.stop, size: 16),
                  label: const Text('Berhenti', style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ===========================================================================
  // HELPER COMPONENTS
  // ===========================================================================

  Widget _buildStatCard(String title, String count, IconData icon, Color iconBg, Color themeColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bgCard, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: Colors.black54), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: themeColor)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: themeColor, size: 18),
          )
        ],
      ),
    );
  }

  Widget _buildMiniStatCard(String title, String count, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(color: bgCard, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 9, color: Colors.black54), maxLines: 1),
          Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildPendingBox(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bgCard, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const Text('Tidak ada tiket pending', style: TextStyle(fontSize: 11, color: Colors.black45)),
        ],
      ),
    );
  }

  Widget _buildTiketSampahItem(String nama, String nik, String berat, String tanggal, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bgCard, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  nama,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildStatusBadge(status),
            ],
          ),
          Text(nik, style: const TextStyle(fontSize: 10, color: Colors.black45)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 1, thickness: 0.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Estimasi Berat', style: TextStyle(fontSize: 11, color: Colors.black54)),
              Text(berat, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tanggal', style: TextStyle(fontSize: 11, color: Colors.black54)),
              Text(tanggal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTiketPoinItem(String nama, String nik, String poin, String voucher, String tanggal, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bgCard, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  nama,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildStatusBadge(status),
            ],
          ),
          Text(nik, style: const TextStyle(fontSize: 10, color: Colors.black45)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 1, thickness: 0.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Poin Ditukar', style: TextStyle(fontSize: 11, color: Colors.black54)),
              Text(poin, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Voucher', style: TextStyle(fontSize: 11, color: Colors.black54)),
              Text(voucher, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tanggal', style: TextStyle(fontSize: 11, color: Colors.black54)),
              Text(tanggal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg = const Color(0xFFDCFCE7);
    Color text = const Color(0xFF15803D);

    if (status == 'Dibatalkan') {
      bg = const Color(0xFFFEE2E2);
      text = const Color(0xFFB91C1C);
    } else if (status == 'Menunggu') {
      bg = const Color(0xFFFEF9C3);
      text = const Color(0xFFA16207);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(status, style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 9)),
    );
  }
}