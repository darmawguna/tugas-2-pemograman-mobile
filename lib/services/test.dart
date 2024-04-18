import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tugaske2/models/petani_model.dart';

Future<Petani> fetchPetani() async {
  final response =
      await http.get(Uri.parse('https://dev.wefgis.com/api/petani?s'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var json = jsonDecode(response.body);
    final data = json['data'];

    // ignore: avoid_print
    print(Petani.fromJson((data) as Map<String, dynamic>));

    return Petani.fromJson((data) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
