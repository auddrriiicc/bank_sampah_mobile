import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://187.77.114.100/v2/api';

  // 1. AUTHENTICATION & LOGIN (Mengecek ke Database Website)
  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && (data['success'] == true || data['status'] == 'success')) {
        return {
          'success': true,
          'role': data['user']['role'] ?? data['role'], // super_admin, admin_bank, atau masyarakat
          'user': data['user'],
          'message': 'Login berhasil'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Username atau password tidak ditemukan / salah'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server website: $e'};
    }
  }

  // 2. PENDAFTARAN MASYARAKAT BARU (Langsung Masuk Database Website)
  static Future<Map<String, dynamic>> registerMasyarakat(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'message': 'Pendaftaran berhasil! Silakan login.'};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Gagal mendaftar'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error koneksi: $e'};
    }
  }

  // 3. MASYARAKAT
  static Future<List<dynamic>> getMasyarakat() async {
    final response = await http.get(Uri.parse('$baseUrl/super-admin/masyarakat'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? jsonDecode(response.body);
    }
    throw Exception('Gagal mengambil data masyarakat');
  }

  // 4. BANK SAMPAH
  static Future<List<dynamic>> getBankSampah() async {
    final response = await http.get(Uri.parse('$baseUrl/super-admin/bank-sampah'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? jsonDecode(response.body);
    }
    throw Exception('Gagal mengambil data bank sampah');
  }

  static Future<bool> createBankSampah(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/super-admin/bank-sampah/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  // 5. EDUKASI
  static Future<List<dynamic>> getArtikel() async {
    final response = await http.get(Uri.parse('$baseUrl/super-admin/edukasi'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? jsonDecode(response.body);
    }
    throw Exception('Gagal mengambil data artikel');
  }

  static Future<bool> createArtikel(String judul, String isi, String? filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/super-admin/edukasi/create'));
    request.fields['judul'] = judul;
    request.fields['isi'] = isi;

    var response = await request.send();
    return response.statusCode == 200 || response.statusCode == 201;
  }

  // 6. PENGATURAN
  static Future<Map<String, dynamic>> getPengaturan() async {
    final response = await http.get(Uri.parse('$baseUrl/super-admin/pengaturan'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Gagal mengambil pengaturan');
  }

  static Future<bool> updatePengaturan(int gramPerPoin, int poinPerVoucher) async {
    final response = await http.post(
      Uri.parse('$baseUrl/super-admin/pengaturan/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'gram_per_poin': gramPerPoin,
        'poin_per_voucher': poinPerVoucher,
      }),
    );
    return response.statusCode == 200;
  }
}