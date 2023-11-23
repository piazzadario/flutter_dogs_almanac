import 'package:dogs_almanac/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DogsAlmanac());
}

class DogsAlmanac extends StatelessWidget {
  const DogsAlmanac({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
