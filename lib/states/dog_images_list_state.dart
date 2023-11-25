import 'package:dogs_almanac/enum/request_status.dart';
import 'package:equatable/equatable.dart';

class DogImagesListState extends Equatable {
  /// Map in which:
  ///   - [key] is the name of the breed (and optionally sub-breed)
  ///   - [value] is the corresponding [BreedImages], including the request status
  final Map<String, BreedImages> map;

  const DogImagesListState({
    required this.map,
  });

  factory DogImagesListState.initial() {
    return const DogImagesListState(
      map: {},
    );
  }

  DogImagesListState copyWith(
    MapEntry<String, BreedImages> breedImages,
  ) {
    return DogImagesListState(
      map: {}
        ..addAll(map)
        ..addEntries([breedImages]),
    );
  }

  BreedImages get(String breed, {String? subBreed}) {
    return map[_getBreedKey(breed, subBreed: subBreed)] ??
        BreedImages.initial();
  }

  /// Utility function to extract a key by a breed and (optionally) a sub-breed
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

/// Represents the list of the image for a certaing breed associated to the request [status]
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
