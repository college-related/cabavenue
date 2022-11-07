import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
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

  Future<List<LatLng>> getRoutingPolyPoint(
    BuildContext context,
    startLat,
    startLng,
    desLat,
    desLng,
  ) async {
    List<LatLng> polys = [];
    try {
      await http
          .get(
        Uri.parse(
            'https://api.geoapify.com/v1/routing?waypoints=$startLat,$startLng|$desLat,$desLng&mode=drive&apiKey=$api'),
      )
          .then((value) {
        if (value.statusCode == 200) {
          var latlngs = jsonDecode(value.body)["features"][0]["geometry"]
              ["coordinates"][0];

          for (var element in latlngs) {
            polys.add(LatLng(element[1], element[0]));
          }
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
    return polys;
  }
}
