import 'package:flutter/material.dart';
import 'package:tugaske2/models/petani_model.dart';
import 'package:tugaske2/screens/form_petani.dart';
import 'package:tugaske2/screens/home_page.dart';
import 'package:tugaske2/services/petani_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Petani>> futurePetani;
  final APiService apiService = APiService();

  @override
  void initState() {
    super.initState();
    
    futurePetani = apiService.fetchPetani();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas API'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TambahEditPetaniPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: HomePage(futurePetani: futurePetani),
      ),
    );
  }
}
