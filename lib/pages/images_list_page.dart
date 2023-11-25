import 'package:dogs_almanac/bloc/dog_images_list_bloc.dart';
import 'package:dogs_almanac/bloc/dog_random_image_bloc.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/extensions/string_extension.dart';
import 'package:dogs_almanac/states/dog_images_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return _RefetchRandomImageButton(
                breed: widget.breed,
                subBreed: widget.subBreed,
              );
            case RequestStatus.success:
              return GridView.count(
                crossAxisCount: 2,
                children: [
                  ...imagesState.images.map((e) => Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(e))),
                      ))
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
      label: Text('Get another $_buttonTitle image'),
    );
  }

  String get _buttonTitle {
    final breedText = subBreed != null
        ? '${subBreed?.capitalized()} ${breed.capitalized()}'
        : breed.capitalized();

    return '$breedText Random Pic';
  }
}

class _DogImageCard extends StatelessWidget {
  final String imageUrl;

  const _DogImageCard(
    this.imageUrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
