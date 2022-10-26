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

  dynamic searchRides(BuildContext context, String lat, String lng) async {
    String token = await _tokenService.getToken();

    try {
      var places = await http.get(
        Uri.parse('http://$url/v1/rides/$lat/$lng'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
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
        Uri.parse('http://$url/v1/rides'),
        body: jsonEncode(request),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
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
}
