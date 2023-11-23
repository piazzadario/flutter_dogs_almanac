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
}
