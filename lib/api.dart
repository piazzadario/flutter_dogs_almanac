import 'dart:convert';

import 'package:dogs_almanac/models/breed.dart';
import 'package:http/http.dart' as http;

class Api {
  final http.Client client;

  static const String _baseUrl = 'https://dog.ceo/api';

  Api({http.Client? client}) : client = client ?? http.Client();

  Future<String> getRandomImageByBreed(String breed) async {
    final response =
        await client.get(Uri.parse('$_baseUrl/breed/$breed/images/random'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }

    throw Exception('Failed to load $breed random image');
  }

  Future<List<String>> getImagesByBreed(String breed) async {
    final response =
        await client.get(Uri.parse('$_baseUrl/breed/$breed/images'));
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body)['message']);
    }

    throw Exception('Failed to load $breed images');
  }

  Future<String> getRandomImageBySubBreed({
    required String breed,
    required String subBreed,
  }) async {
    final response = await client
        .get(Uri.parse('$_baseUrl/breed/$breed/$subBreed/images/random'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }

    throw Exception('Failed to load $breed/$subBreed images');
  }

  Future<List<String>> getImagesBySubBreed({
    required String breed,
    required String subBreed,
  }) async {
    final response =
        await client.get(Uri.parse('$_baseUrl/breed/$breed/$subBreed/images'));
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body)['message']);
    }

    throw Exception('Failed to load $breed/$subBreed images');
  }

  Future<List<Breed>> getAllBreeds() async {
    final response = await client.get(Uri.parse('$_baseUrl/breeds/list/all'));
    if (response.statusCode == 200) {
      final breedsMap = jsonDecode(response.body)['message'] as Map;
      return breedsMap.entries.map(Breed.fromMapEntry).toList();
    }

    throw Exception('Failed to load breeds');
  }
}
