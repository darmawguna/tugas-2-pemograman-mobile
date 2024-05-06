import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugaske2/models/kelompok_tani_model.dart';
import 'package:tugaske2/services/petani_service.dart';

class InputFormPetani extends StatefulWidget {
  const InputFormPetani({super.key});

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Lakukan sesuatu dengan data yang sudah diisi
      print('Alamat: $_nik');
      print('Alamat: $_nama');
      print('Alamat: $_alamat');
      print('Telepon: $_telp');
      print('ID Kelompok Tani: $_idKelompok');
      print('Status: $_status');
      print('Foto Path: $_fotoPath');
    }
  }

  // method untuk fetching data kelompok tani
  Future<void> _fetchKelompokTani() async {
    try {
      List<KelompokPetani> _kelompokList = await APiService.getKelompokTani();
    } catch (e) {
      print('Error fetching kelompok tani: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Panggil method untuk mengambil daftar kelompok tani
    // _fetchKelompokTani();
    // futurePetani = apiService.fetchPetani();
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
                decoration: const InputDecoration(labelText: 'Nik'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
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
                    return 'Alamat tidak boleh kosong';
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
                leading: Radio(
                  value: "inactive",
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value.toString();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Active"),
                leading: Radio(
                  value: "active",
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value.toString();
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
                      controller: TextEditingController(text: _fotoPath),
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
                  _submitForm();
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
