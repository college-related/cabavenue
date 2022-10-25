import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PlacesApiService {
  String? api = dotenv.env['PLACES_API_GEOAPIFY'];

  dynamic autocomplete(BuildContext context, String searchText) async {
    try {
      var places = await http.get(
        Uri.parse(
            'https://api.geoapify.com/v1/geocode/autocomplete?text=$searchText&filter=rect:83.93546520999064,28.14962403393544,84.06995844714743,28.281521725201657&format=json&apiKey=$api'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });

      return places;
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }
}
