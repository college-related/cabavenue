import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('Current location unit testing', () {
    test('Get details of location through latitude and longitude', () async {
      final currenLocationTest = CurrenLocationTest();

      await currenLocationTest.getCurrentLocationDetails(
        "28.2589596",
        "83.9683814",
      );

      expect(currenLocationTest.sourceLocation, {
        "name": "Gandaki college of engineering and science",
        "latitude": "28.2589596",
        "longitude": "83.9683814",
      });
    });
  });
}

class CurrenLocationTest {
  dynamic sourceLocation;
  String? api = dotenv.env['PLACES_API_GEOAPIFY'];

  Future<void> getCurrentLocationDetails(
    String latitude,
    String longitude,
  ) async {
    var locationData = await http.get(
      Uri.parse(
          'https://api.geoapify.com/v1/geocode/reverse?lat=$latitude&lon=$longitude&format=json&apiKey=$api'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((value) {
      if (value.statusCode == 200) {
        var place = jsonDecode(value.body)['results'][0];
        return {
          "name": place["name"],
          "latitude": place["lat"],
          "longitude": place["lon"],
        };
      } else {
        return {};
      }
    });

    sourceLocation = locationData;
  }
}
