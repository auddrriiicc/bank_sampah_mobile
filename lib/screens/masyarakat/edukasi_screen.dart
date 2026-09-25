import 'package:flutter/material.dart';
import '../../services/api_service.dart'; // Sesuaikan path jika berbeda

class EdukasiScreen extends StatefulWidget {
  const EdukasiScreen({super.key});

  @override
  State<EdukasiScreen> createState() => _EdukasiScreenState();
}

class _EdukasiScreenState extends State<EdukasiScreen> {
  late Future<List<dynamic>> _artikelFuture;

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi API saat layar dibuka
    _artikelFuture = ApiService.getArtikel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edukasi Sampah'), 
        backgroundColor: const Color(0xFF11522E), 
        foregroundColor: Colors.white
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _artikelFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada artikel edukasi.'));
          }

          final artikelList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: artikelList.length,
            itemBuilder: (context, index) {
              final artikel = artikelList[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.eco, color: Colors.green),
                  title: Text(artikel['judul'] ?? 'Tanpa Judul'),
                  subtitle: Text(
                    artikel['deskripsi'] ?? 'Tidak ada deskripsi',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}