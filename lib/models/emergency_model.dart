import 'dart:convert';

class EmergencyModel {
  String name;
  int phone;
  dynamic vehicleData;

  EmergencyModel({
    required this.name,
    required this.phone,
    required this.vehicleData,
  });

  factory EmergencyModel.fromJson(Map<String, dynamic> jsonData) {
    return EmergencyModel(
      name: jsonData['name'],
      phone: jsonData['phone'],
      vehicleData: jsonData['vehicleData'],
    );
  }

  static Map<String, dynamic> toMap(EmergencyModel model) => {
        'phone': model.phone,
        'name': model.name,
        'vehicleData': model.vehicleData,
      };

  static String serialize(EmergencyModel model) =>
      json.encode(EmergencyModel.toMap(model));

  static Future<EmergencyModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 1),
      () => EmergencyModel.fromJson(jsonDecode(json)));

  static EmergencyModel deserializeFast(String json) =>
      EmergencyModel.fromJson(jsonDecode(json));
}
