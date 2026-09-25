import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'masyarakat/masyarakat_dashboard.dart';
import 'admin_bank/admin_bank_dashboard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaCtrl = TextEditingController();
  final _nikCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String _jenisKelamin = 'Laki-laki';
  String _role = 'masyarakat'; // Default role
  bool _isLoading = false;

  @override
  void dispose() {
    _namaCtrl.dispose();
    _nikCtrl.dispose();
    _phoneCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // Fungsi Bypass untuk melompat ke Dashboard sesuai Role (Hanya untuk testing UI)
  void _bypassKeDashboard() {
    final mockUser = {
      'nama': _namaCtrl.text.isNotEmpty ? _namaCtrl.text : 'Tester User',
      'role': _role,
    };

    Widget targetPage = _role == 'admin_bank'
        ? AdminBankDashboard(userData: mockUser)
        : MasyarakatDashboard(userData: mockUser);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
      (route) => false, 
    );
  }

  Future<void> _handleRegister() async {
    if (_namaCtrl.text.isEmpty || _nikCtrl.text.isEmpty || _usernameCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field bertanda * wajib diisi!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final data = {
      'nama': _namaCtrl.text.trim(),
      'nik': _nikCtrl.text.trim(),
      'no_hp': _phoneCtrl.text.trim(),
      'jenis_kelamin': _jenisKelamin,
      'username': _usernameCtrl.text.trim(),
      'password': _passwordCtrl.text.trim(),
      'role': _role, // Role dikirim dinamis berdasarkan pilihan dropdown
      'status': 'Menunggu',
    };

    final result = await ApiService.registerMasyarakat(data);

    setState(() => _isLoading = false);
    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Kembali ke login jika sukses tersimpan di database
    } else {
      // JIKA GAGAL TERHUBUNG KE SERVER, MUNCULKAN OPSI BYPASS
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Server Gagal Dihubungi'),
          content: Text('${result['message']}\n\nApakah Anda ingin memaksa masuk (bypass) ke Dashboard (${_role == 'admin_bank' ? 'Admin Bank' : 'Masyarakat'}) untuk testing UI?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF11522E),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(ctx); 
                _bypassKeDashboard(); 
              },
              child: const Text('Ya, Lihat Dashboard'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF11522E);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F4),
      appBar: AppBar(
        title: const Text('Pendaftaran Akun', style: TextStyle(color: Colors.black87, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Buat Akun Baru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryGreen)),
                const SizedBox(height: 4),
                const Text('Data akan dikirim ke server website untuk diverifikasi', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 20),

                // -- DROPDOWN PILIHAN ROLE PENDAFTARAN --
                DropdownButtonFormField<String>(
                  value: _role,
                  decoration: const InputDecoration(
                    labelText: 'Daftar Sebagai *',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xFFF3F6F4),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'masyarakat', child: Text('Masyarakat (Warga)')),
                    DropdownMenuItem(value: 'admin_bank', child: Text('Admin Bank Sampah')),
                  ],
                  onChanged: (val) => setState(() => _role = val!),
                ),
                const SizedBox(height: 12),

                TextField(controller: _namaCtrl, decoration: const InputDecoration(labelText: 'Nama Lengkap *', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: _nikCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'NIK *', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: _phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'No. Handphone', border: OutlineInputBorder())),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _jenisKelamin,
                  decoration: const InputDecoration(labelText: 'Jenis Kelamin', border: OutlineInputBorder()),
                  items: ['Laki-laki', 'Perempuan'].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                  onChanged: (val) => setState(() => _jenisKelamin = val!),
                ),
                const SizedBox(height: 12),

                TextField(controller: _usernameCtrl, decoration: const InputDecoration(labelText: 'Username Login *', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: _passwordCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password *', border: OutlineInputBorder())),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('DAFTAR SEKARANG', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}