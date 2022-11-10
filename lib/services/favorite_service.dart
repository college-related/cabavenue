import 'dart:convert';

import 'package:cabavenue/helpers/error_handler.dart';
import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/models/user_model.dart';
import 'package:cabavenue/providers/profile_provider.dart';
import 'package:cabavenue/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FavoriteService {
  String? url = dotenv.env['BACKEND_URL_WITH_PORT'];
  final TokenService _tokenService = TokenService();

  dynamic getFavorites(BuildContext context) async {
    String token = await _tokenService.getToken();
    String id = await _tokenService.getUserId();

    try {
      var favoritePlaces = await http.get(
        Uri.parse('$url/v1/users/favorite/$id'),
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

      return favoritePlaces;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
      return [];
    }
  }

  void deleteFavorite(
    BuildContext context,
    int index,
  ) async {
    String token = await _tokenService.getToken();
    String userId = await _tokenService.getUserId();

    try {
      var favoritePlaces = await http.delete(
        Uri.parse('$url/v1/users/favorite/$userId'),
        body: jsonEncode({"index": index}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return value;
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });

      if (favoritePlaces != null) {
        String token = await TokenService().getToken();

        UserModel newUser = UserModel(
          name: jsonDecode(favoritePlaces.body)["name"],
          isEmailVerified: jsonDecode(favoritePlaces.body)["isEmailVerified"],
          isPhoneVerified: jsonDecode(favoritePlaces.body)["isPhoneVerified"],
          email: jsonDecode(favoritePlaces.body)["email"],
          phone: jsonDecode(favoritePlaces.body)["phone"],
          address: jsonDecode(favoritePlaces.body)["address"],
          accessToken: token,
          id: jsonDecode(favoritePlaces.body)["id"],
          profileUrl: jsonDecode(favoritePlaces.body)["profileUrl"],
          rideHistory: jsonDecode(favoritePlaces.body)["rideHistory"],
          favoritePlaces: jsonDecode(favoritePlaces.body)["favoritePlaces"],
          isInRide: jsonDecode(favoritePlaces.body)["isInRide"],
        );

        const FlutterSecureStorage().write(
          key: "CABAVENUE_USERDATA_PASSENGER",
          value: UserModel.serialize(newUser),
        );
        // ignore: use_build_context_synchronously
        Provider.of<ProfileProvider>(context, listen: false)
            .setUserData(newUser);

        Fluttertoast.showToast(
          msg: 'Favorite place deleted successfully',
          backgroundColor: Colors.lightGreen[300],
          textColor: Colors.black87,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
    }
  }

  Future<void> addFavorite(
    BuildContext context,
    int iconIndex,
    double latitude,
    double longitude,
    String givenName,
  ) async {
    String token = await _tokenService.getToken();
    String userId = await _tokenService.getUserId();

    try {
      var place = {
        'givenName': givenName,
        'latitude': latitude,
        'longitude': longitude,
        'iconIndex': iconIndex,
      };

      var favoritePlaces = await http.patch(
        Uri.parse('$url/v1/users/favorite/$userId'),
        body: jsonEncode(place),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return value;
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });

      if (favoritePlaces != null) {
        String token = await TokenService().getToken();

        UserModel newUser = UserModel(
          name: jsonDecode(favoritePlaces.body)["name"],
          isEmailVerified: jsonDecode(favoritePlaces.body)["isEmailVerified"],
          isPhoneVerified: jsonDecode(favoritePlaces.body)["isPhoneVerified"],
          email: jsonDecode(favoritePlaces.body)["email"],
          phone: jsonDecode(favoritePlaces.body)["phone"],
          address: jsonDecode(favoritePlaces.body)["address"],
          accessToken: token,
          id: jsonDecode(favoritePlaces.body)["id"],
          profileUrl: jsonDecode(favoritePlaces.body)["profileUrl"],
          rideHistory: jsonDecode(favoritePlaces.body)["rideHistory"],
          favoritePlaces: jsonDecode(favoritePlaces.body)["favoritePlaces"],
          isInRide: jsonDecode(favoritePlaces.body)["isInRide"],
        );

        const FlutterSecureStorage().write(
          key: "CABAVENUE_USERDATA_PASSENGER",
          value: UserModel.serialize(newUser),
        );
        // ignore: use_build_context_synchronously
        Provider.of<ProfileProvider>(context, listen: false)
            .setUserData(newUser);

        Fluttertoast.showToast(
          msg: 'Favorite place added successfully',
          backgroundColor: Colors.lightGreen[300],
          textColor: Colors.black87,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
    }
  }

  void editFavorite(
    BuildContext context,
    int index,
    int iconIndex,
    double latitude,
    double longitude,
    String givenName,
  ) async {
    String token = await _tokenService.getToken();
    String userId = await _tokenService.getUserId();

    try {
      var place = {
        'givenName': givenName,
        'latitude': latitude,
        'longitude': longitude,
        'iconIndex': iconIndex,
        'index': index,
      };

      var favoritePlaces = await http.patch(
        Uri.parse('$url/v1/users/favorite/$userId'),
        body: jsonEncode(place),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      ).then((value) {
        if (value.statusCode == 200) {
          return value;
        } else {
          httpErrorHandle(response: value, context: context, onSuccess: () {});
        }
      });

      if (favoritePlaces != null) {
        String token = await TokenService().getToken();

        UserModel newUser = UserModel(
          name: jsonDecode(favoritePlaces.body)["name"],
          isEmailVerified: jsonDecode(favoritePlaces.body)["isEmailVerified"],
          isPhoneVerified: jsonDecode(favoritePlaces.body)["isPhoneVerified"],
          email: jsonDecode(favoritePlaces.body)["email"],
          phone: jsonDecode(favoritePlaces.body)["phone"],
          address: jsonDecode(favoritePlaces.body)["address"],
          accessToken: token,
          id: jsonDecode(favoritePlaces.body)["id"],
          profileUrl: jsonDecode(favoritePlaces.body)["profileUrl"],
          rideHistory: jsonDecode(favoritePlaces.body)["rideHistory"],
          favoritePlaces: jsonDecode(favoritePlaces.body)["favoritePlaces"],
          isInRide: jsonDecode(favoritePlaces.body)["isInRide"],
        );

        const FlutterSecureStorage().write(
          key: "CABAVENUE_USERDATA_PASSENGER",
          value: UserModel.serialize(newUser),
        );
        // ignore: use_build_context_synchronously
        Provider.of<ProfileProvider>(context, listen: false)
            .setUserData(newUser);

        Fluttertoast.showToast(
          msg: 'Favorite place updated successfully',
          backgroundColor: Colors.lightGreen[300],
          textColor: Colors.black87,
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), true);
    }
  }
}
