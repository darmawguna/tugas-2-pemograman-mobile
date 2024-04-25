import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tugaske2/models/petani_model.dart';

class APiService {
  // Fetch all petani
  Future<List<Petani>> fetchPetani() async {
    final response =
        await http.get(Uri.parse('https://dev.wefgis.com/api/petani?s'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      final data = json['data'];

      if (data is List) {
        return data.map((petaniJson) => Petani.fromJson(petaniJson)).toList();
      } else {
        throw Exception('Data is not in the expected format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Create a new petani
  Future<Petani> createPetani(Petani petani) async {
    final response = await http.post(
      Uri.parse('https://dev.wefgis.com/api/petani'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_kelompok_tani': petani.idKelompokTani,
        'nama': petani.nama,
        'nik': petani.nik,
        'alamat': petani.alamat,
        'telp': petani.telp,
        'foto': petani.foto,
        'status': petani.status,
        'nama_kelompok': petani.namaKelompok,
      }),
    );

    if (response.statusCode == 201) {
      return Petani.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create petani');
    }
  }

  // Update an existing petani
  Future<Petani> updatePetani(Petani petani) async {
    final response = await http.put(
      Uri.parse('https://dev.wefgis.com/api/petani/${petani.idPenjual}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id_kelompok_tani': petani.idKelompokTani,
        'nama': petani.nama,
        'nik': petani.nik,
        'alamat': petani.alamat,
        'telp': petani.telp,
        'foto': petani.foto,
        'status': petani.status,
        'nama_kelompok': petani.namaKelompok,
      }),
    );

    if (response.statusCode == 200) {
      return Petani.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update petani');
    }
  }

  // Delete a petani
  Future<void> deletePetani(String idPenjual) async {
    final response = await http.delete(
      Uri.parse('https://dev.wefgis.com/api/petani/$idPenjual'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete petani');
    }
  }
}
