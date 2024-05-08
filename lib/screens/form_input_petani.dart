import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugaske2/main.dart';
import 'package:tugaske2/models/kelompok_tani_model.dart';
import 'package:tugaske2/models/petani_model.dart';
import 'package:tugaske2/services/petani_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class InputFormPetani extends StatefulWidget {
  final Petani petani;
  const InputFormPetani({required this.petani,super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputFormPetaniState createState() => _InputFormPetaniState();
}

class _InputFormPetaniState extends State<InputFormPetani> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _nik = '';
  String _nama = '';
  String _alamat = '';
  String _telp = '';
  String _idKelompok = '';
  String _status = 'inactive';
  String _fotoPath = '';

  final APiService apiService = APiService();

  // Tambahkan variabel untuk menyimpan daftar kelompok tani
  KelompokPetani? _selectedKelompok;
  List<KelompokPetani> _kelompokList = [];

  // Metode untuk memilih foto
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _fotoPath = pickedFile.path;
      });
    }
  }

  // final List<KelompokPetani> _kelompokLis = [
  //   KelompokPetani(idKelompokTani: '1', namaKelompok: 'Suda Mula'),
  //   KelompokPetani(idKelompokTani: '2', namaKelompok: 'Sandi Merta'),
  //   KelompokPetani(idKelompokTani: '3', namaKelompok: 'Jaya Mula'),
  //   KelompokPetani(idKelompokTani: '4', namaKelompok: 'Sudiwana Mandiri'),
  // ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Lakukan sesuatu dengan data yang sudah diisi
      print('Nama: $_nama');
      print('NIK: $_nik');
      print('Alamat: $_alamat');
      print('Telepon: $_telp');
      print('ID Kelompok Tani: $_idKelompok');
      print('Status: $_status');
      print('Foto Path: $_fotoPath');
    }
  }

  void _saveData() async {
    try {
      await APiService.savePetani(
          Petani(
            idKelompokTani: _idKelompok,
            nama: _nama,
            nik: _nik,
            alamat: _alamat,
            telp: _telp,
            // foto: _fotoPath,
            status: _status,
          ),
          _fotoPath);
      Fluttertoast.showToast(
        msg: 'Data berhasil ditambahkan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      // Kembali ke halaman utama
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // method untuk fetching data kelompok tani
  Future<void> _fetchKelompokTani() async {
    try {
      final response =
          await http.get(Uri.parse('https://dev.wefgis.com/api/kelompoktani'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        setState(() {
          _kelompokList =
              jsonData.map((item) => KelompokPetani.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchKelompokTani();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Form Petani'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'NIK'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (newValue) => _nik = newValue!,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (newValue) => _nama = newValue!,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (newValue) => _alamat = newValue!,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telepon tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (newValue) => _telp = newValue!,
              ),
              const SizedBox(height: 20.0),
              // Dropdown untuk kelompok tani
              DropdownButtonFormField<KelompokPetani>(
                value: _selectedKelompok,
                onChanged: (newValue) {
                  setState(() {
                    _selectedKelompok = newValue;
                    _idKelompok = newValue!.idKelompokTani;
                  });
                },
                items: _kelompokList.map<DropdownMenuItem<KelompokPetani>>(
                    (KelompokPetani kelompok) {
                  return DropdownMenuItem<KelompokPetani>(
                    value: kelompok,
                    child: Text(kelompok.namaKelompok),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Kelompok Tani',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Pilih kelompok tani';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              // Radio button untuk status
              ListTile(
                title: const Text("Inactive"),
                leading: Radio<String>(
                  value: "inactive",
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Active"),
                leading: Radio<String>(
                  value: "active",
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Foto',
                      ),
                      // controller: TextEditingController(text: _fotoPath),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_camera),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  // _submitForm();
                  _saveData();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
