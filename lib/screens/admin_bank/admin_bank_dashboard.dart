import 'package:flutter/material.dart';

class AdminBankDashboard extends StatefulWidget {
  final Map<String, dynamic>? userData;
  const AdminBankDashboard({super.key, this.userData});

  @override
  State<AdminBankDashboard> createState() => _AdminBankDashboardState();
}

class _AdminBankDashboardState extends State<AdminBankDashboard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Center(child: Text('Beranda Admin Bank')),
    const Center(child: Text('Tiket Sampah')),
    const Center(child: Text('Tiket Poin')), // Merujuk ke[cite: 32]
    const Center(child: Text('Scan QR')), // Merujuk ke[cite: 31]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Admin Bank'), backgroundColor: const Color(0xFF11522E)),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF11522E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Tiket Sampah'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tiket Poin'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan QR'),
        ],
      ),
    );
  }
}