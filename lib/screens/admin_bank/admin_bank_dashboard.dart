import 'package:flutter/material.dart';

class AdminBankDashboard extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const AdminBankDashboard({super.key, this.userData});

  @override
  State<AdminBankDashboard> createState() => _AdminBankDashboardState();
}

class _AdminBankDashboardState extends State<AdminBankDashboard> {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF11522E);
    final namaUser = widget.userData?['nama'] ?? widget.userData?['username'] ?? 'Admin Bank';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin Bank'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Selamat Datang, $namaUser!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Akses Role: ADMIN BANK',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}