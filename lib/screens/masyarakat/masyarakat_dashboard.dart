import 'package:flutter/material.dart';

class MasyarakatDashboard extends StatefulWidget {
  final Map<String, dynamic>? userData;
  const MasyarakatDashboard({super.key, this.userData});

  @override
  State<MasyarakatDashboard> createState() => _MasyarakatDashboardState();
}

class _MasyarakatDashboardState extends State<MasyarakatDashboard> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Center(child: Text('Beranda Masyarakat')),
    const Center(child: Text('Tukar Sampah')),
    const Center(child: Text('Riwayat')),
    const Center(child: Text('Profil & Edukasi')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bank Sampah Sekanak'), backgroundColor: const Color(0xFF11522E)),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF11522E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.recycling), label: 'Tukar'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}