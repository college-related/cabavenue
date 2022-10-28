import 'package:cabavenue/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<String> getToken() async {
    var u =
        await _flutterSecureStorage.read(key: "CABAVENUE_USERDATA_PASSENGER");

    var user = UserModel.deserializeFast(u ?? '{}');

    return user.accessToken;
  }

  Future<String> getUserId() async {
    var u =
        await _flutterSecureStorage.read(key: "CABAVENUE_USERDATA_PASSENGER");

    var user = UserModel.deserializeFast(u ?? '{}');

    return user.id;
  }
}
