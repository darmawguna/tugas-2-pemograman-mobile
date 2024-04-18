import 'package:flutter/material.dart';
import 'package:tugaske2/models/petani_model.dart';
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
  late Future<Petani> futurePetani;

  @override
  void initState() {
    super.initState();
    futurePetani = fetchPetani();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Petani>(
            future: futurePetani,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final petani = snapshot.data!;
                // return Text("${petani.nama}");
                return ListView.builder(
                  itemCount: petani.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return PetaniList(petani: petani[index]);
                    return Text(petani[index].nama);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}