import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/models/user_model.dart';
import 'package:cabavenue/providers/device_provider.dart';
import 'package:cabavenue/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

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
          UserModel user = UserModel(
            name: jsonDecode(res.body)["user"]["name"],
            isEmailVerified: jsonDecode(res.body)["user"]["isEmailVerified"],
            isPhoneVerified: jsonDecode(res.body)["user"]["isPhoneVerified"],
            email: jsonDecode(res.body)["user"]["email"],
            phone: jsonDecode(res.body)["user"]["phone"],
            address: jsonDecode(res.body)["user"]["address"],
            accessToken: jsonDecode(res.body)["tokens"]["access"]["token"],
            id: jsonDecode(res.body)["user"]["id"],
            profileUrl: jsonDecode(res.body)["user"]["profileUrl"],
            rideHistory: jsonDecode(res.body)["user"]["rideHistory"],
            favoritePlaces: jsonDecode(res.body)["user"]["favoritePlaces"],
            isInRide: jsonDecode(res.body)["user"]["isInRide"],
          );
          const FlutterSecureStorage().write(
            key: "CABAVENUE_USERDATA_PASSENGER",
            value: UserModel.serialize(user),
          );
          Fluttertoast.showToast(
            msg: 'Registered successfully',
            backgroundColor: Colors.green[300],
          );
          Provider.of<ProfileProvider>(context, listen: false)
              .setUserData(user);
          Provider.of<DeviceProvider>(context, listen: false).update(context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
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
          UserModel user = UserModel(
            name: jsonDecode(res.body)["user"]["name"],
            isEmailVerified: jsonDecode(res.body)["user"]["isEmailVerified"],
            isPhoneVerified: jsonDecode(res.body)["user"]["isPhoneVerified"],
            email: jsonDecode(res.body)["user"]["email"],
            phone: jsonDecode(res.body)["user"]["phone"],
            address: jsonDecode(res.body)["user"]["address"],
            accessToken: jsonDecode(res.body)["tokens"]["access"]["token"],
            id: jsonDecode(res.body)["user"]["id"],
            profileUrl: jsonDecode(res.body)["user"]["profileUrl"],
            rideHistory: jsonDecode(res.body)["user"]["rideHistory"],
            favoritePlaces: jsonDecode(res.body)["user"]["favoritePlaces"],
            isInRide: jsonDecode(res.body)["user"]["isInRide"],
          );
          const FlutterSecureStorage().write(
            key: "CABAVENUE_USERDATA_PASSENGER",
            value: UserModel.serialize(user),
          );
          Fluttertoast.showToast(
            msg: 'Logged in successfully',
            backgroundColor: Colors.green[300],
          );
          Provider.of<ProfileProvider>(context, listen: false)
              .setUserData(user);
          Provider.of<DeviceProvider>(context, listen: false).update(context);

          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void logout(context) async {
    const FlutterSecureStorage().delete(key: "CABAVENUE_USERDATA_PASSENGER");
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    Fluttertoast.showToast(
      msg: 'Logged out',
      backgroundColor: Colors.green[600],
    );
  }
}
