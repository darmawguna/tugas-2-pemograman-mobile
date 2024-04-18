import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tugaske2/models/petani_model.dart';

Future<List<Petani>> fetchPetani() async {
  final response =
      await http.get(Uri.parse('https://dev.wefgis.com/api/petani?s'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response,
    // then parse the JSON.
    var json = jsonDecode(response.body);
    final data = json['data'];

    if (data is List) {
      // Check if data is a list
      return data.map((petaniJson) => Petani.fromJson(petaniJson)).toList();
    } else {
      throw Exception('Data is not in the expected format');
    }
  } else {
    // If the server does not return a 200 OK response,
    // throw an exception.
    throw Exception('Failed to load data');
  }
}
