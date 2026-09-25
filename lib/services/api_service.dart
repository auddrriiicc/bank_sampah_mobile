import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://bank-sampah-backend.vercel.app/api';

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

  // FUNGSI REGISTER MASYARAKAT
  static Future<Map<String, dynamic>> registerMasyarakat(Map<String, dynamic> dataUser) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dataUser),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Pendaftaran berhasil!'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Pendaftaran gagal'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server: $e'};
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