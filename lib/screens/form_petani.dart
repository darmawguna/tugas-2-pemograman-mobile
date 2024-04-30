import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugaske2/main.dart';
import 'package:tugaske2/models/kelompok_tani_model.dart';
import 'package:tugaske2/models/petani_model.dart';
import 'package:tugaske2/services/petani_service.dart';

class TambahEditPetaniPage extends StatefulWidget {
  final Petani? petani;

  const TambahEditPetaniPage({super.key, this.petani});

  @override
  State<TambahEditPetaniPage> createState() => _TambahEditPetaniPageState();
}

class _TambahEditPetaniPageState extends State<TambahEditPetaniPage> {
  late Future<List<Petani>> futurePetani;
  final APiService apiService = APiService();
  late String idKelompok;

  // Tambahkan variabel untuk menyimpan daftar kelompok tani
  List<Kelompok> kelompokList = [];

  // Tambahkan variabel untuk menyimpan nilai kelompok tani yang dipilih
  Kelompok? selectedKelompok;

  // Method untuk mengambil daftar kelompok tani dari server
  void _fetchKelompokTani() async {
    try {
      List<Kelompok> kelompok = await APiService.getKelompokTani();
      setState(() {
        kelompokList = kelompok;
        if (widget.petani != null) {
          // Jika ada data petani, set nilai idKelompok sesuai dengan data petani
          idKelompok = widget.petani!.idKelompokTani!;
          // Set nilai selectedKelompok sesuai dengan data petani
          selectedKelompok = kelompok.firstWhere(
            (kelompok) =>
                // ignore: unrelated_type_equality_checks
                kelompok.idKelompokTani == widget.petani!.idKelompokTani,
            orElse: () => kelompokList[
                0], // Jika tidak ditemukan, pilih elemen pertama dari kelompokList
          );
        }
      });
    } catch (e) {
      // Tangani kesalahan jika terjadi
      print('Error fetching kelompok tani: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Panggil method untuk mengambil daftar kelompok tani
    _fetchKelompokTani();
    futurePetani = apiService.fetchPetani();
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = widget.petani == null ? 'Tambah Petani' : 'Edit Petani';
    

    // Controller untuk mengelola nilai input
    TextEditingController _namaController = TextEditingController();
    TextEditingController _nikController = TextEditingController();
    TextEditingController _alamatController = TextEditingController();
    TextEditingController _teleponController = TextEditingController();
    TextEditingController _statusController = TextEditingController();
    
    // Implementasi logika untuk menyimpan nilai foto

    // Inisialisasi nilai input jika sedang dalam mode edit
    if (widget.petani != null) {
      _namaController.text = widget.petani!.nama ?? '';
      _nikController.text = widget.petani!.nik ?? '';
      _alamatController.text = widget.petani!.alamat ?? '';
      _teleponController.text = widget.petani!.telp ?? '';
      _statusController.text = widget.petani!.status ?? '';
      idKelompok = widget.petani!.idKelompokTani!.toString();
      
      // Implementasi logika untuk menampilkan foto
    }

    // method to get kelompok tani

    _saveData(Petani? petani, BuildContext context) async {
      try {
        if (petani == null) {
          await APiService().createPetani(Petani(
            // Masukkan nilai dari TextFormField ke dalam konstruktor Petani
            idKelompokTani: idKelompok,
            nama: _namaController.text,
            nik: _nikController.text,
            alamat: _alamatController.text,
            telp: _teleponController.text,
            status: _statusController.text,
            // Tambahkan nilai foto jika diperlukan
          ));
          // Implementasi jika penyimpanan berhasil
          Fluttertoast.showToast(
            msg: 'Data berhasil ditambahkan', // Pesan toast kesuksesan
            toastLength: Toast.LENGTH_SHORT, // Durasi toast
            gravity: ToastGravity.BOTTOM, // Posisi toast pada layar
            backgroundColor: Colors.green, // Warna latar belakang toast
            textColor: Colors.white, // Warna teks pada toast
          );
        } else {
          await APiService().updatePetani(Petani(
            // Masukkan nilai dari TextFormField ke dalam konstruktor Petani
            idPenjual: petani.idPenjual,
            idKelompokTani: idKelompok,
            nama: _namaController.text,
            nik: _nikController.text,
            alamat: _alamatController.text,
            telp: _teleponController.text,
            status: _statusController.text,
            // Tambahkan nilai foto jika diperlukan
          ));
          // Implementasi jika penyimpanan berhasil
          Fluttertoast.showToast(
            msg: 'Data berhasil diperbarui', // Pesan toast kesuksesan
            toastLength: Toast.LENGTH_SHORT, // Durasi toast
            gravity: ToastGravity.BOTTOM, // Posisi toast pada layar
            backgroundColor: Colors.green, // Warna latar belakang toast
            textColor: Colors.white, // Warna teks pada toast
          );
        }

        // kembali ke halaman utama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
            // builder: (context) => HomePage(futurePetani: futurePetani),
          ),
        );
      } catch (e) {
        // Implementasi jika terjadi kesalahan saat menyimpan data
        Fluttertoast.showToast(
          msg: 'Error: $e', // Pesan yang akan ditampilkan pada toast
          toastLength: Toast.LENGTH_LONG, // Durasi toast
          gravity: ToastGravity.BOTTOM, // Posisi toast pada layar
          backgroundColor: Colors.red, // Warna latar belakang toast
          textColor: Colors.white, // Warna teks pada toast
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              Padding(
                padding: const EdgeInsets.all(5),
                child: DropdownButtonFormField<Kelompok>(
                  value:
                      selectedKelompok, // Nilai terpilih sesuai dengan data petani
                  hint: const Text("Pilih Kelompok"),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.category_rounded),
                  ),
                  items: kelompokList.map((item) {
                    return DropdownMenuItem<Kelompok>(
                      value: item,
                      child: Text("${item.namaKelompok}"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedKelompok = value!;
                      idKelompok = value.idKelompokTani
                          .toString(); // Update nilai idKelompok
                    });
                  },
                  validator: (value) => value == null ? "Wajib Diisi" : null,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.petani == null) {
            _saveData(null, context);
          } else {
            _saveData(widget.petani, context);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
