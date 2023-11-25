import 'package:dogs_almanac/enum/request_status.dart';
import 'package:equatable/equatable.dart';

class DogImagesListState extends Equatable {
  final Map<String, BreedImages> map;

  DogImagesListState({
    required this.map,
  });

  factory DogImagesListState.initial() {
    return DogImagesListState(
      map: {},
    );
  }

  DogImagesListState copyWith(
    MapEntry<String, BreedImages> breedImages,
  ) {
    return DogImagesListState(
      map: map..addEntries([breedImages]),
    );
  }

  BreedImages get(String breed, {String? subBreed}) {
    return map[_getBreedKey(breed, subBreed: subBreed)] ??
        BreedImages.initial();
  }

  String _getBreedKey(String breed, {String? subBreed}) {
    if (subBreed != null) {
      return '$subBreed-$breed';
    }

    return breed;
  }

  @override
  List<Object?> get props => [
        map.values,
      ];
}

class BreedImages extends Equatable {
  final RequestStatus status;
  final List<String> images;

  const BreedImages({
    required this.status,
    required this.images,
  });

  factory BreedImages.initial() {
    return const BreedImages(
      status: RequestStatus.initial,
      images: [],
    );
  }

  factory BreedImages.pending() {
    return const BreedImages(
      status: RequestStatus.pending,
      images: [],
    );
  }

  @override
  List<Object?> get props => [
        status,
        images,
      ];
}
