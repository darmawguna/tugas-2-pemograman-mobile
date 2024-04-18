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
  late Future<List<Petani>> futurePetani;

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
          child: FutureBuilder<List<Petani>>(
            future: futurePetani,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for the future
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Display an error message if there's an error
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Display the list of Petani if data is available
                final List<Petani> petaniList = snapshot.data!;
                return ListView.builder(
                  itemCount: petaniList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Display each Petani's name
                    return Text('${petaniList[index].nama}');
                  },
                );
              } else {
                // Default case: Display a message when there's no data
                return const Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
