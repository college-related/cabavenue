import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];

  void signUpUser({
    required BuildContext context,
    required String email,
    required String phone,
    required String address,
    required String name,
    required String password,
  }) async {
    try {
      var toSendUser = {
        'name': name,
        'email': email,
        'address': address,
        'phone': phone,
        'password': password,
      };

      http.Response res = await http.post(
        Uri.parse('http://$url/v1/auth/register'),
        body: jsonEncode(toSendUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.of(context).pushNamed('/');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void loginUser({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    try {
      var user = {
        'phone': phone,
        'password': password,
      };

      http.Response res = await http.post(
        Uri.parse('http://$url/v1/auth/login'),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.of(context).pushNamed('/');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }
}
