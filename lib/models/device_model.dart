import 'dart:convert';

class DeviceModel {
  String firebaseToken;
  String? user;
  String id;

  DeviceModel({
    required this.firebaseToken,
    this.user,
    required this.id,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> jsonData) {
    return DeviceModel(
      firebaseToken: jsonData['firebaseToken'],
      user: jsonData['user'],
      id: jsonData['_id'],
    );
  }

  static Map<String, dynamic> toMap(DeviceModel model) => {
        'firebaseToken': model.firebaseToken,
        'user': model.user,
        'id': model.id,
      };

  static String serialize(DeviceModel model) =>
      json.encode(DeviceModel.toMap(model));

  static Future<DeviceModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 2), () => DeviceModel.fromJson(jsonDecode(json)));

  static DeviceModel deserializeFast(String json) =>
      DeviceModel.fromJson(jsonDecode(json));
}
