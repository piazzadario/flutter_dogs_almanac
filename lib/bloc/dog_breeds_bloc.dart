import 'package:bloc/bloc.dart';
import 'package:dogs_almanac/api.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/states/dog_breeds_state.dart';
import 'package:http/http.dart' as http;

class DogBreedsBloc extends Bloc<DogsEvent, DogBreedsState> {
  final http.Client client;
  DogBreedsBloc({http.Client? client})   : client = client ?? http.Client(),  super(DogBreedsState.initial()) {
    on<GetBreeds>(_onGetBreeds);
  }

  void _onGetBreeds(DogsEvent event, Emitter emit) async {
    try {
      emit(state.copyWith(
        status: RequestStatus.pending,
      ));

      final breeds = await Api(client: client).getAllBreeds();
      return emit(state.copyWith(
        status: RequestStatus.success,
        breeds: breeds,
      ));
    } catch (_) {
      return emit(state.copyWith(
        status: RequestStatus.failed,
      ));
    }
  }
}
