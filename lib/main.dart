import 'package:dogs_almanac/bloc/dog_breeds_bloc.dart';
import 'package:dogs_almanac/events/dogs_event.dart';
import 'package:dogs_almanac/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const DogsAlmanac());
}

class DogsAlmanac extends StatelessWidget {
  const DogsAlmanac({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DogBreedsBloc()..add(GetBreeds()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
