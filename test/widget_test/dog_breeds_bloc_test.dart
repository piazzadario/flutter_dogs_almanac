import 'package:bloc_test/bloc_test.dart';
import 'package:dogs_almanac/bloc/dog_breeds_bloc.dart';
import 'package:dogs_almanac/enum/request_status.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/models/breed.dart';
import 'package:dogs_almanac/states/dog_breeds_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'image_list_bloc_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late DogBreedsBloc bloc;

  setUp(() {
    mockClient = MockClient();
    bloc = DogBreedsBloc(client: mockClient);
  });

  blocTest(
    'should emit [DogBreedsState.loading, DogBreedsState.success] when request is successful',
    build: () {
      when(mockClient.get(Uri.parse('https://dog.ceo/api/breeds/list/all')))
          .thenAnswer(
              (_) async => http.Response('{"message": {"corgi": []}}', 200));
      return bloc;
    },
    act: (bloc) => bloc.add(GetBreeds()),
    expect: () => [
      const DogBreedsState(status: RequestStatus.pending, breeds: []),
      const DogBreedsState(
        status: RequestStatus.success,
        breeds: [
          Breed(name: 'corgi'),
        ],
      ),
    ],
  );
}
