import 'package:dogs_almanac/bloc/dog_breeds_bloc.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/extensions/string_extension.dart';
import 'package:dogs_almanac/models/breed.dart';
import 'package:dogs_almanac/pages/images_list_page.dart';
import 'package:dogs_almanac/pages/random_pic_page.dart';
import 'package:dogs_almanac/states/dog_breeds_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedsSearchPage extends StatelessWidget {
  final bool includeSubBreeds;
  final bool isList;
  final String title;
  final TextEditingController _controller = TextEditingController();

  BreedsSearchPage({
    this.includeSubBreeds = false,
    this.isList = false,
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
              return const _BreedsSearchError();
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
                        final List<_BreedSearchResult> allBreeds =
                            includeSubBreeds
                                ? state.breeds
                                    .where((breed) => breed.hasSubBreeds)
                                    .toSubBreedsSearchResult()
                                : state.breeds.toBreedsSearchResult();

                        final filteredBreeds = allBreeds.where((result) =>
                            result
                                .toString()
                                .toLowerCase()
                                .contains(value.text));

                        if (filteredBreeds.isEmpty) {
                          return _EmptySearchResult(searchTerm: value.text);
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: filteredBreeds.length,
                          itemBuilder: (context, index) {
                            final result = filteredBreeds.elementAt(index);
                            return _BreedSearchResultCard(
                              result,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      if (isList) {
                                        return ImagesListPage(
                                          breed: result.breed,
                                          subBreed: result.subBreed,
                                        );
                                      }

                                      return RandomPicPage(
                                        breed: result.breed,
                                        subBreed: result.subBreed,
                                      );
                                    },
                                  ),
                                );
                              },
                            );
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
  final _BreedSearchResult result;

  final VoidCallback onTap;

  const _BreedSearchResultCard(
    this.result, {
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            _title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  String get _title {
    return result.subBreed != null
        ? '${result.subBreed?.capitalized()} ${result.breed.capitalized()}'
        : result.breed.capitalized();
  }
}

class _BreedSearchResult {
  final String breed;
  final String? subBreed;

  _BreedSearchResult({
    required this.breed,
    this.subBreed,
  });

  @override
  String toString() {
    if (subBreed != null) {
      return '${subBreed!.capitalized()} ${breed.capitalized()}';
    }
    return breed.capitalized();
  }
}

extension on Breed {
  _BreedSearchResult toBreedSearchResult() {
    return _BreedSearchResult(breed: name);
  }

  List<_BreedSearchResult> toSubBreedSearchResult() {
    return subBreeds
        .map((subBreed) => _BreedSearchResult(breed: name, subBreed: subBreed))
        .toList();
  }
}

extension on Iterable<Breed> {
  List<_BreedSearchResult> toSubBreedsSearchResult() {
    List<_BreedSearchResult> result = [];
    for (final breed in this) {
      result.addAll(breed.toSubBreedSearchResult());
    }

    return result;
  }

  List<_BreedSearchResult> toBreedsSearchResult() {
    return map((breed) => breed.toBreedSearchResult()).toList();
  }
}
