import 'package:flutter/material.dart';
import 'package:tugaske2/models/petani_model.dart';
import 'package:tugaske2/screens/detail_page_petani.dart';
import 'package:tugaske2/screens/form_petani.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.futurePetani,
  });

  final Future<List<Petani>> futurePetani;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Petani>>(
        future: widget.futurePetani,
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
            return Container(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: petaniList.length,
                itemBuilder: (BuildContext context, int index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => DetailPetaniPage(
                              petani: petaniList[index],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${petaniList[index].foto}"),
                                radius: 20,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '${petaniList[index].nama}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Add code for edit action here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TambahEditPetaniPage(
                                        petani: petaniList[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final confirmed = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure you want to delete this petani?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              // Add code for delete action here
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (confirmed) {
                                    // Add code for delete action here
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            // Default case: Display a message when there's no data
            return const Text('No data available');
          }
        },
      ),
    );
  }
}
