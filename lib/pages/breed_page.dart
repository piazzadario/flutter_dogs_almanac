import 'package:dogs_almanac/api.dart';
import 'package:dogs_almanac/models/breed.dart';
import 'package:flutter/material.dart';

class BreedPage extends StatefulWidget {
  final Breed breed;

  const BreedPage(this.breed, {super.key});

  @override
  State<BreedPage> createState() => _BreedPageState();
}

class _BreedPageState extends State<BreedPage> {
  late Future<String> _getRandomImageFuture;

  @override
  void initState() {
    _getRandomImageFuture = Api().getRandomImageByBreed(widget.breed.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.breed.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _getRandomImageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 300,
                    width: 300,
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  children: [
                    Image.network(snapshot.data!),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.refresh),
                      label: Text('Get random image'),
                    )
                  ],
                );
              },
            ),
            ...widget.breed.subBreeds.map((e) => Text(e))
          ],
        ),
      ),
    );
  }
}
