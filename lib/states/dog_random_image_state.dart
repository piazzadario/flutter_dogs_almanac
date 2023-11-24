import 'package:dogs_almanac/enum/request_status.dart';
import 'package:equatable/equatable.dart';

class DogRandomImageState extends Equatable {
  final RequestStatus status;
  final String? imageUrl;

  const DogRandomImageState({
    required this.status,
    this.imageUrl,
  });

  factory DogRandomImageState.initial() {
    return const DogRandomImageState(
      status: RequestStatus.initial,
    );
  }

  DogRandomImageState copyWith({
    RequestStatus? status,
    String? imageUrl,
  }) {
    return DogRandomImageState(
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        status,
        imageUrl,
      ];
}
