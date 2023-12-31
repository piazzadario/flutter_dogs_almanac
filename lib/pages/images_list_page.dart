import 'package:dogs_almanac/bloc/dog_images_list_bloc.dart';
import 'package:dogs_almanac/bloc/dog_random_image_bloc.dart';
import 'package:dogs_almanac/components/dog_image_card.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/extensions/string_extension.dart';
import 'package:dogs_almanac/states/dog_images_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Displays the list of the dogs of a given [breed] and (optionally)[subBreed]
class ImagesListPage extends StatefulWidget {
  final String breed;
  final String? subBreed;

  const ImagesListPage({
    required this.breed,
    this.subBreed,
    super.key,
  });

  @override
  State<ImagesListPage> createState() => _ImagesListPageState();
}

class _ImagesListPageState extends State<ImagesListPage> {
  @override
  void initState() {
    final bloc = context.read<DogImagesListBloc>();
    if (bloc.state.get(widget.breed, subBreed: widget.subBreed).status ==
        RequestStatus.initial) {
      bloc.add(
        GetImagesByBreed(breed: widget.breed, subBreed: widget.subBreed),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_appBarTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<DogImagesListBloc, DogImagesListState>(
        builder: (context, state) {
          final BreedImages imagesState =
              state.get(widget.breed, subBreed: widget.subBreed);

          switch (imagesState.status) {
            case RequestStatus.initial:
            case RequestStatus.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestStatus.failed:
              return Center(
                child: _RefetchImagesButton(
                  breed: widget.breed,
                  subBreed: widget.subBreed,
                ),
              );
            case RequestStatus.success:
              return GridView.count(
                padding: const EdgeInsets.all(8),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
                children: [
                  ...imagesState.images.map((image) => DogImageCard(image)),
                ],
              );
          }
        },
      ),
    );
  }

  String get _appBarTitle {
    final breedText = widget.subBreed != null
        ? '${widget.subBreed?.capitalized()} ${widget.breed.capitalized()}'
        : widget.breed.capitalized();

    return '$breedText Pics';
  }
}

class _RefetchImagesButton extends StatelessWidget {
  final String breed;
  final String? subBreed;

  const _RefetchImagesButton({
    required this.breed,
    this.subBreed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<DogRandomImageBloc>().add(
              GetImagesByBreed(
                breed: breed,
                subBreed: subBreed,
              ),
            );
      },
      icon: const Icon(Icons.refresh),
      label: const Text('Retry'),
    );
  }

}

