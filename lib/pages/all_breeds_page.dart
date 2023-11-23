import 'package:dogs_almanac/api.dart';
import 'package:dogs_almanac/extensions/string_extension.dart';
import 'package:dogs_almanac/models/breed.dart';
import 'package:flutter/material.dart';

class AllBreedsPage extends StatefulWidget {
  const AllBreedsPage({super.key});

  @override
  State<AllBreedsPage> createState() => _AllBreedsPageState();
}

class _AllBreedsPageState extends State<AllBreedsPage> {
  late final Future<List<Breed>> _allBreedsFuture;

  @override
  void initState() {
    _allBreedsFuture = Api().getAllBreeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All breeds'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Breed>>(
        future: _allBreedsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return _AllBreedsList(snapshot.data!);
          }
        },
      ),
    );
  }
}

class _AllBreedsList extends StatelessWidget {
  final List<Breed> breeds;
  final TextEditingController _controller = TextEditingController();

  _AllBreedsList(
    this.breeds, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar(
            controller: _controller,
            hintText: "e.g. \"Beagle\"",
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, child) {
              final filteredBreeds = breeds.where(
                  (breed) => breed.name.toLowerCase().contains(value.text));
              if (filteredBreeds.isEmpty) {
                return Center(
                  child: Text(
                    'No results for "${value.text}".\nTry with a different breed.',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredBreeds.length,
                itemBuilder: (context, index) {
                  return BreedCard(filteredBreeds.elementAt(index));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class BreedCard extends StatelessWidget {
  final Breed breed;

  const BreedCard(
    this.breed, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            breed.name.capitalized(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
/* class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Breed>> _randomDogRequest;

  @override
  void initState() {
    _randomDogRequest = Api().getAllBreeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Breed>>(
        future: _randomDogRequest,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              return AllBreedsPage(snapshot.data!);
          }
        },
      ),
    );
  }
} */