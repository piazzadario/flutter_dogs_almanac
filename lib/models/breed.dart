import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  final String name;
  final List<String> subBreeds;

  const Breed({
    required this.name,
    this.subBreeds = const [],
  });

  factory Breed.fromMapEntry(MapEntry entry) {
    return Breed(
      name: entry.key,
      subBreeds: List.from(entry.value),
    );
  }

  bool get hasSubBreeds => subBreeds.isNotEmpty;

  @override
  List<Object?> get props => [
        name,
        subBreeds,
      ];
}
