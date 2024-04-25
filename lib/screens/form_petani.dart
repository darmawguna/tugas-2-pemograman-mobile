import 'package:flutter/material.dart';
import 'package:tugaske2/models/petani_model.dart';


class TambahEditPetaniPage extends StatelessWidget {
  final Petani? petani;

  const TambahEditPetaniPage({super.key, this.petani});

  @override
  Widget build(BuildContext context) {
    String pageTitle = petani == null ? 'Tambah Petani' : 'Edit Petani';
    String buttonText = petani == null ? 'Tambah' : 'Simpan';

    // Controller untuk mengelola nilai input
    TextEditingController _namaController = TextEditingController();
    TextEditingController _nikController = TextEditingController();
    TextEditingController _alamatController = TextEditingController();
    TextEditingController _teleponController = TextEditingController();
    TextEditingController _statusController = TextEditingController();
    TextEditingController _kelompokController = TextEditingController();
    // Implementasi logika untuk menyimpan nilai foto

    // Inisialisasi nilai input jika sedang dalam mode edit
    if (petani != null) {
      _namaController.text = petani!.nama ?? '';
      _nikController.text = petani!.nik ?? '';
      _alamatController.text = petani!.alamat ?? '';
      _teleponController.text = petani!.telp ?? '';
      _statusController.text = petani!.status ?? '';
      _kelompokController.text = petani!.idKelompokTani ?? '';
      // Implementasi logika untuk menampilkan foto
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: _nikController,
              decoration: const InputDecoration(labelText: 'NIK'),
            ),
            TextFormField(
              controller: _alamatController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            TextFormField(
              controller: _teleponController,
              decoration: const InputDecoration(labelText: 'Telepon'),
            ),
            TextFormField(
              controller: _statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            TextFormField(
              controller: _kelompokController,
              decoration: const InputDecoration(labelText: 'Nama Kelompok'),
            ),
            // Implementasi input untuk foto
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementasi logika untuk menyimpan data petani baru atau menyimpan perubahan pada data petani yang sudah ada
              },
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
