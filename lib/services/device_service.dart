import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DeviceService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  dynamic fetchByFirebaseToken(BuildContext context, firebaseToken) async {
    try {
      var device = await http.get(
        Uri.parse('http://$url/v1/devices/byFirebaseToken/$firebaseToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return value.body;
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return null;
        }
      });

      return device;
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  dynamic createNew(BuildContext context, firebaseToken) async {
    try {
      var device = {
        'firebaseToken': firebaseToken,
      };

      var remoteDevice = await http.post(
        Uri.parse('http://$url/v1/devices'),
        body: jsonEncode(device),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((value) {
        if (value.statusCode == 201) {
          return jsonDecode(value.body);
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return null;
        }
      });

      return remoteDevice;
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  dynamic updateDevice(
    BuildContext context,
    String id,
    String userId,
    String access,
  ) async {
    try {
      var device = {
        'user': userId,
      };

      var remoteDevice = await http.patch(
        Uri.parse('http://$url/v1/devices/$id'),
        body: jsonEncode(device),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return value.body;
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
          return null;
        }
      });

      return remoteDevice;
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void deleteDevice(BuildContext context, String firebasetoken) async {
    try {
      String? token = await _tokenService.getToken();

      await http.delete(
        Uri.parse('http://$url/v1/devices/$firebasetoken'),
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
      showSnackBar(context, e.toString(), true);
    }
  }
}
