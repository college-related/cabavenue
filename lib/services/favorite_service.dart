import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  dynamic getFavorites(BuildContext context) async {
    String token = await _tokenService.getToken();
    String id = await _tokenService.getUserId();

    try {
      var favoritePlaces = await http.get(
        Uri.parse('http://$url/v1/users/favorite/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return jsonDecode(value.body);
        } else if (value.statusCode == 401 &&
            jsonDecode(value.body)['message'] == 'Please Authenticate') {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/auth', (route) => false);
          Fluttertoast.showToast(
            msg: 'Session finished. Please login again',
            backgroundColor: Colors.red[400],
          );
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return [];
        }
      });

      return favoritePlaces;
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
