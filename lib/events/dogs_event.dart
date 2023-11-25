sealed class DogsEvent {}

class GetBreeds extends DogsEvent {}

class GetRandomImageByBreed extends DogsEvent {
  final String breed;
  final String? subBreed;

  GetRandomImageByBreed({
    required this.breed,
    this.subBreed,
  });
}

class GetImagesByBreed extends DogsEvent {
  final String breed;
  final String? subBreed;

  GetImagesByBreed({
    required this.breed,
    this.subBreed,
  });
}
