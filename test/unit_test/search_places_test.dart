import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Places search and cancel', () {
    test('places list must be filled with values', () async {
      final searchPlace = SearchPlace();

      await searchPlace.search('bag');

      expect(searchPlace.places.isNotEmpty, true);
    });

    test('places list must be empty', () {
      final searchPlace = SearchPlace();

      searchPlace.resetPlaces();

      expect(searchPlace.places, []);
    });
  });
}

class SearchPlace {
  List places = [];
  String? api = dotenv.env['PLACES_API_GEOAPIFY'];

  Future<void> search(String text) async {
    var searchedPalces = await http.get(
      Uri.parse(
          'https://api.geoapify.com/v1/geocode/autocomplete?text=$text&filter=rect:83.93546520999064,28.14962403393544,84.06995844714743,28.281521725201657&format=json&apiKey=$api'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((value) {
      if (value.statusCode == 200) {
        return jsonDecode(value.body);
      } else {
        return;
      }
    });
    places.addAll(searchedPalces['results']);
  }

  void resetPlaces() {
    places.clear();
  }
}
