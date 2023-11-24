import 'package:bloc/bloc.dart';
import 'package:dogs_almanac/api.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/states/dog_random_image_state.dart';

class DogRandomImageBloc extends Bloc<DogsEvent, DogRandomImageState> {
  DogRandomImageBloc() : super(DogRandomImageState.initial()) {
    on<GetRandomImageByBreed>(_onGetRadomImage);
  }

  void _onGetRadomImage(
    GetRandomImageByBreed event,
    Emitter emit,
  ) async {
    try {
      emit(state.copyWith(
        status: RequestStatus.pending,
      ));

      final String imageUrl;
      if (event.subBreed == null) {
        imageUrl = await Api().getRandomImageByBreed(event.breed);
      } else {
        imageUrl = await Api().getRandomImageBySubBreed(
            breed: event.breed, subBreed: event.subBreed!);
      }

      return emit(state.copyWith(
        status: RequestStatus.success,
        imageUrl: imageUrl,
      ));
    } catch (_) {
      return emit(state.copyWith(
        status: RequestStatus.failed,
      ));
    }
  }
}
