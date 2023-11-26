import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/models/breed.dart';
import 'package:equatable/equatable.dart';

/// Represents the list of the [breeds] associated to the request [status]
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

  @override
  List<Object?> get props => [
        status,
        breeds,
      ];
}
