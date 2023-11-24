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
