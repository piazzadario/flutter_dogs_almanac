import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/models/breed.dart';
import 'package:equatable/equatable.dart';

class DogBreedsState extends Equatable {
  final RequestStatus status;
  final List<Breed> breeds;

  const DogBreedsState({
    required this.status,
    required this.breeds,
  });

  factory DogBreedsState.initial() {
    return const DogBreedsState(
      status: RequestStatus.initial,
      breeds: [],
    );
  }

  DogBreedsState copyWith({
    RequestStatus? status,
    List<Breed>? breeds,
  }) {
    return DogBreedsState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
    );
  }

  List<String> getAllSubBreeds() {
    List<String> result = [];
    for (final breed in breeds) {
      if (breed.hasSubBreeds) {
        result.addAll(
            breed.subBreeds.map((subBreed) => '$subBreed ${breed.name}'));
      } else {
        result.add(breed.name);
      }
    }

    return result;
  }

  @override
  List<Object?> get props => [
        status,
        breeds,
      ];
}
