import 'package:flutter/material.dart';

import 'package:tugaske2/models/petani_model.dart';


class DetailPetaniPage extends StatefulWidget {
  const DetailPetaniPage({super.key, required this.petani});
  final Petani petani;

  @override
  State<DetailPetaniPage> createState() => _DetailPetaniPageState();
}

class _DetailPetaniPageState extends State<DetailPetaniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.petani.nama}"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  "${widget.petani.foto}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        Text('Gambar tidak dapat diakses'),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'ID Penjual: ${widget.petani.idPenjual}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('ID Kelompok Tani: ${widget.petani.idKelompokTani}'),
              const SizedBox(height: 16),
              Text(
                'Nama: ${widget.petani.nama}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('NIK: ${widget.petani.nik}'),
              const SizedBox(height: 8),
              Text('Alamat: ${widget.petani.alamat}'),
              const SizedBox(height: 8),
              Text('No. Telp: ${widget.petani.telp}'),
              const SizedBox(height: 16),
              Text(
                'Foto: ${widget.petani.foto}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Status: ${widget.petani.status}'),
              const SizedBox(height: 16),
              Text(
                'Nama Kelompok: ${widget.petani.namaKelompok}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
