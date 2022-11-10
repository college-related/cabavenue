// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  sendRideRequestNotification(
    BuildContext context,
    String id,
    String title,
    String body,
  ) async {
    String token = await _tokenService.getToken();

    try {
      var request = {
        "title": title,
        "desc": body,
        "to": 'driver',
      };

      await http.post(
        Uri.parse('$url/v1/devices/notify/$id'),
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
      showSnackBar(context, e.toString(), true);
    }
  }
}
