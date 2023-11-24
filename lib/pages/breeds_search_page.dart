import 'package:dogs_almanac/bloc/dog_breeds_bloc.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/extensions/string_extension.dart';
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
      body: BlocBuilder<DogBreedsBloc, DogBreedsState>(
        builder: (context, state) {
          switch (state.status) {
            case RequestStatus.initial:
            case RequestStatus.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestStatus.failed:
              return _BreedsSearchError();
            case RequestStatus.success:
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
                        final allBreeds = includeSubBreeds
                            ? state.getAllSubBreeds()
                            : state.breeds.map((b) => b.name);

                        final filteredBreeds = allBreeds.where((breedName) =>
                            breedName.toLowerCase().contains(value.text));

                        if (filteredBreeds.isEmpty) {
                          return _EmptySearchResult(searchTerm: value.text);
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: filteredBreeds.length,
                          itemBuilder: (context, index) {
                            return _BreedSearchResultCard(
                                filteredBreeds.elementAt(index));
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class _BreedsSearchError extends StatelessWidget {
  const _BreedsSearchError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'An error occurred.\nPlease try again',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<DogBreedsBloc>().add(GetBreeds());
          },
          icon: const Icon(Icons.replay),
          label: const Text('Try again'),
        )
      ],
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

class _BreedSearchResultCard extends StatelessWidget {
  final String breedName;

  const _BreedSearchResultCard(
    this.breedName, {
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
            breedName.capitalized(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
