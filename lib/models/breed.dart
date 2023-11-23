class Breed {
  final String name;
  final List<String> subBreeds;

  Breed({
    required this.name,
    required this.subBreeds,
  });

  factory Breed.fromMapEntry(MapEntry entry) {
    return Breed(
      name: entry.key,
      subBreeds: List.from(entry.value),
    );
  }

  bool get hasSubBreeds => subBreeds.isNotEmpty;
}
