import 'package:dogs_almanac/bloc/dog_random_image_bloc.dart';
import 'package:dogs_almanac/components/dog_image_card.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/extensions/string_extension.dart';
import 'package:dogs_almanac/states/dog_random_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Displays a random image of a dog of a given [breed] and (optionally)[subBreed]
class RandomPicPage extends StatelessWidget {
  final String breed;
  final String? subBreed;

  const RandomPicPage({
    required this.breed,
    this.subBreed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DogRandomImageBloc()
        ..add(
          GetRandomImageByBreed(
            breed: breed,
            subBreed: subBreed,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_appBarTitle),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocBuilder<DogRandomImageBloc, DogRandomImageState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.initial:
              case RequestStatus.pending:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestStatus.failed:
                return _RefetchRandomImageButton(
                  breed: breed,
                  subBreed: subBreed,
                );
              case RequestStatus.success:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DogImageCard(state.imageUrl!,key: Key('${breed}_image'),),
                      const SizedBox(
                        height: 12,
                      ),
                      _RefetchRandomImageButton(
                        breed: breed,
                        subBreed: subBreed,
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  String get _appBarTitle {
    final breedText = subBreed != null
        ? '${subBreed?.capitalized()} ${breed.capitalized()}'
        : breed.capitalized();

    return '$breedText Random Pic';
  }
}

class _RefetchRandomImageButton extends StatelessWidget {
  final String breed;
  final String? subBreed;

  const _RefetchRandomImageButton({
    required this.breed,
    this.subBreed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<DogRandomImageBloc>().add(
              GetRandomImageByBreed(
                breed: breed,
                subBreed: subBreed,
              ),
            );
      },
      icon: const Icon(Icons.refresh),
      label: Text('Change $_buttonTitle image'),
    );
  }

  String get _buttonTitle {
    return subBreed != null
        ? '${subBreed?.capitalized()} ${breed.capitalized()}'
        : breed.capitalized();
  }
}
