import 'dart:convert';

class UserModel {
  String name;
  bool isEmailVerified;
  bool isPhoneVerified;
  String email;
  int phone;
  String address;
  String id;
  String accessToken;
  String profileUrl;
  List? rideHistory = [];
  List? favoritePlaces = [];
  bool isInRide;

  UserModel({
    required this.name,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.email,
    required this.phone,
    required this.address,
    required this.accessToken,
    required this.id,
    required this.profileUrl,
    required this.isInRide,
    this.rideHistory,
    this.favoritePlaces,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      name: jsonData['name'],
      isEmailVerified: jsonData['isEmailVerified'],
      isPhoneVerified: jsonData['isPhoneVerified'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      address: jsonData['address'],
      accessToken: jsonData['accessToken'],
      id: jsonData['id'],
      profileUrl: jsonData['profileUrl'],
      rideHistory: jsonData['rideHistory'],
      favoritePlaces: jsonData['favoritePlaces'],
      isInRide: jsonData['isInRide'],
    );
  }

  static Map<String, dynamic> toMap(UserModel model) => {
        'isEmailVerified': model.isEmailVerified,
        'isPhoneVerified': model.isPhoneVerified,
        'email': model.email,
        'phone': model.phone,
        'address': model.address,
        'accessToken': model.accessToken,
        'id': model.id,
        'name': model.name,
        'profileUrl': model.profileUrl,
        'rideHistory': model.rideHistory,
        'favoritePlaces': model.favoritePlaces,
        'isInRide': model.isInRide,
      };

  static String serialize(UserModel model) =>
      json.encode(UserModel.toMap(model));

  static Future<UserModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 1), () => UserModel.fromJson(jsonDecode(json)));

  static UserModel deserializeFast(String json) =>
      UserModel.fromJson(jsonDecode(json));
}
