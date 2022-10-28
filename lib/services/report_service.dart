import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReportService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  void report(
    BuildContext context,
    String name,
    String id,
    String reportDes,
  ) async {
    try {
      var report = {
        'userId': id,
        'userType': 'driver',
        'userName': name,
        'report': reportDes,
      };

      String token = await _tokenService.getToken();

      await http.post(
        Uri.parse('http://$url/v1/reports'),
        body: jsonEncode(report),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 401 &&
            jsonDecode(value.body)['message'] == 'Please authenticate') {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/auth', (route) => false);
          showSnackBar(context, 'Session finished, please login again', true);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }
}
