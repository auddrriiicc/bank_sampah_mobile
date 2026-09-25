import 'package:flutter/material.dart';

class SuperAdminDashboard extends StatefulWidget {
  final Map<String, dynamic>? userData;
  const SuperAdminDashboard({super.key, this.userData});

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Center(child: Text('Halaman Beranda')),
    const Center(child: Text('Daftar Masyarakat')), // Merujuk ke[cite: 29]
    const Center(child: Text('Daftar Bank Sampah')), // Merujuk ke[cite: 28]
    const Center(child: Text('Edukasi')), // Merujuk ke[cite: 27]
    const Center(child: Text('Pengaturan')), // Merujuk ke[cite: 26]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Super Admin'), backgroundColor: const Color(0xFF11522E)),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF11522E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Masyarakat'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Bank'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Edukasi'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }
}