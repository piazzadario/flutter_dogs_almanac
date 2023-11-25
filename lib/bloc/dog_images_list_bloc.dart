import 'package:bloc/bloc.dart';
import 'package:dogs_almanac/api.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/states/dog_images_list_state.dart';

class DogImagesListBloc extends Bloc<DogsEvent, DogImagesListState> {
  DogImagesListBloc() : super(DogImagesListState.initial()) {
    on<GetImagesByBreed>(_onGetImagesByBreed);
  }

  void _onGetImagesByBreed(
    GetImagesByBreed event,
    Emitter emit,
  ) async {
    try {
      emit(
        state.copyWith(
          MapEntry(
            _getBreedKey(event.breed, subBreed: event.subBreed),
            BreedImages.pending(),
          ),
        ),
      );

      final List<String> images;
      if (event.subBreed == null) {
        images = await Api().getImagesByBreed(event.breed);
      } else {
        images = await Api()
            .getImagesBySubBreed(breed: event.breed, subBreed: event.subBreed!);
      }

      return emit(state.copyWith(
        MapEntry(
          _getBreedKey(event.breed, subBreed: event.subBreed),
          BreedImages(
            status: RequestStatus.success,
            images: images,
          ),
        ),
      ));
    } catch (_) {
      return emit(
        state.copyWith(
          MapEntry(
            _getBreedKey(event.breed, subBreed: event.subBreed),
            const BreedImages(
              status: RequestStatus.failed,
              images: [],
            ),
          ),
        ),
      );
    }
  }

  String _getBreedKey(String breed, {String? subBreed}) {
    if (subBreed != null) {
      return '$subBreed-$breed';
    }

    return breed;
  }
}
