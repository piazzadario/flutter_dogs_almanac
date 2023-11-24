import 'package:dogs_almanac/bloc/dog_breeds_bloc.dart';
import 'package:dogs_almanac/pages/all_breeds_page.dart';
import 'package:dogs_almanac/states/dog_breeds_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedsSearchPage extends StatelessWidget {
  final bool includeSubBreeds;
  final String title;
  final TextEditingController _controller = TextEditingController();

  BreedsSearchPage({
    this.includeSubBreeds = false,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DogBreedsBloc, DogBreedsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(title),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Column(
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
                    final filteredBreeds = state.breeds.where((breed) =>
                        breed.name.toLowerCase().contains(value.text));

                    if (filteredBreeds.isEmpty) {
                      return _EmptySearchResult(searchTerm: value.text);
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
          ),
        );
      },
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  final String searchTerm;
  const _EmptySearchResult({
    required this.searchTerm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No results for "$searchTerm".\nTry with a different breed.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
