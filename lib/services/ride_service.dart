import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RideService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  dynamic searchRides(
    BuildContext context,
    String lat,
    String lng,
    dynamic source,
    dynamic destination,
  ) async {
    String token = await _tokenService.getToken();

    try {
      var ride = {
        'source': source,
        'destination': destination,
      };

      var rides = await http.post(
        Uri.parse('$url/v1/rides/$lat/$lng'),
        body: jsonEncode(ride),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return null;
        }
      });

      return rides;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return null;
    }
  }

  dynamic requestRide(
    BuildContext context,
    String id,
    dynamic destination,
    dynamic source,
    String price,
  ) async {
    String token = await _tokenService.getToken();
    String userId = await _tokenService.getUserId();

    try {
      var request = {
        "source": source,
        "destination": destination,
        "price": price,
        "driver": id,
        "passenger": userId
      };

      var places = await http.post(
        Uri.parse('$url/v1/rides'),
        body: jsonEncode(request),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 201) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return [];
        }
      });

      return places;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return [];
    }
  }

  void cancelRequest(BuildContext context, String id) async {
    String token = await _tokenService.getToken();

    try {
      await http.delete(
        Uri.parse('$url/v1/rides/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode != 204) {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
    }
  }

  void rateRide(
    BuildContext context,
    String id,
    double rating,
  ) async {
    String token = await _tokenService.getToken();

    try {
      var request = {
        "rating": rating,
      };

      await http.patch(
        Uri.parse('$url/v1/rides/$id'),
        body: jsonEncode(request),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode != 200) {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
    }
  }

  dynamic currentRide(
    BuildContext context,
  ) async {
    String token = await _tokenService.getToken();
    String userId = await _tokenService.getUserId();

    try {
      var currentRide = await http.get(
        Uri.parse('$url/v1/rides/current/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return {
            'rideId': '',
            'driverId': '',
            'driverName': '',
            'model': '',
            'plateNumber': '',
            'color': '',
            'destination': {
              'latitude': '',
              'longitude': '',
              'name': '',
            },
          };
        }
      });

      return currentRide;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return {
        'rideId': '',
        'driverId': '',
        'driverName': '',
        'model': '',
        'plateNumber': '',
        'color': '',
        'destination': {
          'latitude': '',
          'longitude': '',
          'name': '',
        },
      };
    }
  }
}
