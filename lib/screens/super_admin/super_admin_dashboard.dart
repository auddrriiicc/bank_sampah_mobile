import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../login_screen.dart';

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({super.key});

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controller Pengaturan
  final _gramController = TextEditingController();
  final _voucherController = TextEditingController();

  // State Data Dynamic dari API
  List<dynamic> _listMasyarakat = [];
  List<dynamic> _listBankSampah = [];
  List<dynamic> _listArtikel = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    setState(() => _isLoading = true);
    try {
      final masyarakat = await ApiService.getMasyarakat().catchError((_) => []);
      final bankSampah = await ApiService.getBankSampah().catchError((_) => []);
      final artikel = await ApiService.getArtikel().catchError((_) => []);
      final pengaturan = await ApiService.getPengaturan().catchError((_) => {});

      if (mounted) {
        setState(() {
          _listMasyarakat = masyarakat;
          _listBankSampah = bankSampah;
          _listArtikel = artikel;
          if (pengaturan.isNotEmpty) {
            _gramController.text = (pengaturan['gram_per_poin'] ?? 10).toString();
            _voucherController.text = (pengaturan['poin_per_voucher'] ?? 500).toString();
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _gramController.dispose();
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF11522E);
    const accentGreen = Color(0xFF108A43);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: primaryGreen, shape: BoxShape.circle),
              child: const Icon(Icons.bolt, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text('Bank Sampah Sekanak', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: _fetchAllData,
            tooltip: 'Sinkronkan Data Website',
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: primaryGreen,
          unselectedLabelColor: Colors.black54,
          indicatorColor: primaryGreen,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: 'Beranda'),
            Tab(text: 'Masyarakat'),
            Tab(text: 'Bank Sampah'),
            Tab(text: 'Edukasi'),
            Tab(text: 'Pengaturan'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryGreen))
          : TabBarView(
              controller: _tabController,
              children: [
                _buildBerandaTab(primaryGreen),
                _buildMasyarakatTab(accentGreen),
                _buildBankSampahTab(accentGreen),
                _buildEdukasiTab(accentGreen),
                _buildPengaturanTab(primaryGreen),
              ],
            ),
    );
  }

  // ==================== TAB 1: BERANDA ====================
  Widget _buildBerandaTab(Color primaryGreen) {
    return RefreshIndicator(
      onRefresh: _fetchAllData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Ringkasan Sistem Server', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Masyarakat', '${_listMasyarakat.length}', Colors.purple)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Total Bank Sampah', '${_listBankSampah.length}', Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== TAB 2: MASYARAKAT ====================
  Widget _buildMasyarakatTab(Color accentGreen) {
    final pending = _listMasyarakat.where((u) => u['status'] == 'Menunggu').length;
    final approved = _listMasyarakat.where((u) => u['status'] == 'Disetujui').length;

    return RefreshIndicator(
      onRefresh: _fetchAllData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Daftar Masyarakat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Data disinkronkan langsung dari server database', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatBox('Total Masyarakat', '${_listMasyarakat.length}', Colors.black87)),
              const SizedBox(width: 8),
              Expanded(child: _buildStatBox('Menunggu', '$pending', Colors.orange)),
              const SizedBox(width: 8),
              Expanded(child: _buildStatBox('Disetujui', '$approved', Colors.green)),
            ],
          ),
          const SizedBox(height: 20),
          if (_listMasyarakat.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('Belum ada data masyarakat di database.')))
          else
            ..._listMasyarakat.map((item) => _buildUserCard(item, accentGreen)).toList(),
        ],
      ),
    );
  }

  // ==================== TAB 3: BANK SAMPAH ====================
  Widget _buildBankSampahTab(Color accentGreen) {
    return RefreshIndicator(
      onRefresh: _fetchAllData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Daftar Admin/Bank Sampah', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Semua bank sampah terdaftar di database', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showTambahBankSampahForm(context),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Tambah Bank Sampah', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(backgroundColor: accentGreen, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatBox('Total Bank Sampah', '${_listBankSampah.length}', Colors.black87),
          const SizedBox(height: 16),
          ..._listBankSampah.map((item) => Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            color: const Color(0xFFE8F3EB),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildDataRow('Nama Bank Sampah', item['nama'] ?? '-'),
                  const Divider(),
                  _buildDataRow('Kecamatan', item['kecamatan'] ?? '-'),
                  const Divider(),
                  _buildDataRow('Jadwal', item['jam_operasional'] ?? '-'),
                  const Divider(),
                  _buildDataRow('Alamat', item['alamat'] ?? '-'),
                  const Divider(),
                  _buildDataRow('No. Telepon', item['no_telepon'] ?? '-'),
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  // ==================== TAB 4: EDUKASI ====================
  Widget _buildEdukasiTab(Color accentGreen) {
    return RefreshIndicator(
      onRefresh: _fetchAllData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Daftar Artikel Edukasi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Kelola artikel edukasi masyarakat', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showTambahArtikelForm(context),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Tambah Artikel', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(backgroundColor: accentGreen, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatBox('Total Artikel', '${_listArtikel.length}', Colors.black87),
          const SizedBox(height: 16),
          ..._listArtikel.map((item) => Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            color: const Color(0xFFE8F3EB),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['judul'] ?? 'Tanpa Judul', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 6),
                  Text(item['isi'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.black87), maxLines: 3, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 10),
                  Text(item['created_at'] ?? '', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  // ==================== TAB 5: PENGATURAN ====================
  Widget _buildPengaturanTab(Color primaryGreen) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Pengaturan Sistem', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Text('Atur nilai konversi dan simpan ke database website', style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFE8F3EB), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Konversi Gramasi ke Poin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 10),
              TextField(
                controller: _gramController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Gram per Poin', filled: true, fillColor: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFE8F3EB), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Konversi Poin ke Voucher', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 10),
              TextField(
                controller: _voucherController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Poin per Voucher', filled: true, fillColor: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () async {
            final gram = int.tryParse(_gramController.text) ?? 10;
            final voucher = int.tryParse(_voucherController.text) ?? 500;
            final success = await ApiService.updatePengaturan(gram, voucher);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? 'Pengaturan berhasil disimpan ke Database!' : 'Gagal menyimpan pengaturan.')),
              );
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
          child: const Text('Simpan Pengaturan Database', style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  // ==================== FORM MODAL 1 & 2: TAMBAH BANK SAMPAH ====================
  void _showTambahBankSampahForm(BuildContext context) {
    final usernameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final namaCtrl = TextEditingController();
    final alamatCtrl = TextEditingController();
    final areaCtrl = TextEditingController();
    final jamCtrl = TextEditingController();
    final teleponCtrl = TextEditingController();
    final deskripsiCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Akun Login Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextField(controller: usernameCtrl, decoration: const InputDecoration(labelText: 'Username Login Admin *')),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email *')),
              TextField(controller: passwordCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password *')),
              const SizedBox(height: 20),
              const Text('Informasi Bank Sampah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextField(controller: namaCtrl, decoration: const InputDecoration(labelText: 'Nama Bank Sampah *')),
              TextField(controller: alamatCtrl, decoration: const InputDecoration(labelText: 'Alamat *')),
              TextField(controller: areaCtrl, decoration: const InputDecoration(labelText: 'Area / Kecamatan *')),
              TextField(controller: jamCtrl, decoration: const InputDecoration(labelText: 'Jam Operasional * (cth: Senin-Jumat, 08:00-16:00)')),
              TextField(controller: teleponCtrl, decoration: const InputDecoration(labelText: 'Nomor Telepon *')),
              TextField(controller: deskripsiCtrl, decoration: const InputDecoration(labelText: 'Deskripsi (Opsional)')),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF108A43), foregroundColor: Colors.white),
                icon: const Icon(Icons.person_add),
                label: const Text('Buat Akun Admin'),
                onPressed: () async {
                  final data = {
                    'username': usernameCtrl.text,
                    'email': emailCtrl.text,
                    'password': passwordCtrl.text,
                    'nama': namaCtrl.text,
                    'alamat': alamatCtrl.text,
                    'kecamatan': areaCtrl.text,
                    'jam_operasional': jamCtrl.text,
                    'no_telepon': teleponCtrl.text,
                    'deskripsi': deskripsiCtrl.text,
                  };
                  final success = await ApiService.createBankSampah(data);
                  if (context.mounted) {
                    Navigator.pop(context);
                    if (success) {
                      _fetchAllData();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bank Sampah Berhasil Ditambahkan ke Database!')));
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== FORM MODAL 3: TAMBAH ARTIKEL ====================
  void _showTambahArtikelForm(BuildContext context) {
    final judulCtrl = TextEditingController();
    final isiCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Tambah Artikel Edukasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              TextField(controller: judulCtrl, decoration: const InputDecoration(labelText: 'Judul Artikel *')),
              const SizedBox(height: 12),
              TextField(controller: isiCtrl, maxLines: 5, decoration: const InputDecoration(labelText: 'Isi Artikel *', border: OutlineInputBorder())),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF108A43), foregroundColor: Colors.white),
                icon: const Icon(Icons.send),
                label: const Text('Terbitkan Artikel'),
                onPressed: () async {
                  if (judulCtrl.text.isEmpty || isiCtrl.text.isEmpty) return;
                  final success = await ApiService.createArtikel(judulCtrl.text, isiCtrl.text, null);
                  if (context.mounted) {
                    Navigator.pop(context);
                    if (success) {
                      _fetchAllData();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Artikel Berhasil Diterbitkan ke Database Website!')));
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFE8F3EB), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> item, Color accentGreen) {
    final status = item['status'] ?? 'Menunggu';
    final isApproved = status == 'Disetujui';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFE8F3EB), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey.shade300,
                child: Text((item['nama'] ?? 'U')[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(item['nama'] ?? 'Tanpa Nama', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: isApproved ? Colors.green : Colors.amber, borderRadius: BorderRadius.circular(12)),
                child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildDataRow('NIK', item['nik'] ?? '-'),
          _buildDataRow('No. HP', item['no_hp'] ?? '-'),
          _buildDataRow('Jenis Kelamin', item['jenis_kelamin'] ?? '-'),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}