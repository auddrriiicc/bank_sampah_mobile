import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://bank-sampah-backend.vercel.app//api';

  // FUNGSI LOGIN
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
          'role': data['user']?['role'] ?? data['role'],
          'user': data['user'],
          'message': 'Login berhasil'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Username atau password salah'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server: $e'};
    }
  }

  static Future<Map<String, dynamic>> registerMasyarakat(Map<String, dynamic> data) async {
    try {
      final url = Uri.parse('$baseUrl/register'); // Pastikan '/register' adalah rute API yang benar
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      // Cek status code dari server
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Registrasi berhasil',
          'data': jsonDecode(response.body),
        };
      } else {
        // Tangkap pesan error dari API jika ada
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Gagal mendaftar. Silakan coba lagi.',
        };
      }
    } catch (e) {
      // Print error ke terminal untuk mengecek penyebab pastinya
      print('Error detail: $e'); 
      return {
        'success': false,
        'message': 'Gagal terhubung ke server. Periksa koneksi atau URL server.',
      };
    }
  }

  // FUNGSI GET ARTIKEL
  static Future<List<dynamic>> getArtikel() async {
    final response = await http.get(Uri.parse('$baseUrl/super-admin/edukasi'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? jsonDecode(response.body);
    }
    throw Exception('Gagal mengambil data artikel');
  }
}