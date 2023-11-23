import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const String _baseUrl = 'https://dog.ceo/api';

  Future<String> getRandomImageByBreed(String breed) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/breed/$breed/images/random'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }

    throw Exception('Failed to load $breed random image');
  }

  Future<List<String>> getImagesByBreed(String breed) async {
    final response = await http.get(Uri.parse('$_baseUrl/breed/$breed/images'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['message'] as List<dynamic>)
          .map((e) => e.toString())
          .toList();
    }

    throw Exception('Failed to load $breed images');
  }

  Future<String> getRandomImageBySubBreed({
    required String breed,
    required String subBreed,
  }) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/breed/$breed/$subBreed/images/random'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }

    throw Exception('Failed to load $breed/$subBreed images');
  }
}
