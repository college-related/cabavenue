import 'dart:convert';

class FavoriteModel {
  String name;
  String givenName;
  double latitude;
  double longitude;
  int iconIndex;

  FavoriteModel({
    required this.name,
    required this.givenName,
    required this.latitude,
    required this.longitude,
    required this.iconIndex,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> jsonData) {
    return FavoriteModel(
      name: jsonData['name'],
      givenName: jsonData['givenName'],
      iconIndex: jsonData['iconIndex'],
      latitude: jsonData['latitude'],
      longitude: jsonData['longitude'],
    );
  }

  static Map<String, dynamic> toMap(FavoriteModel model) => {
        'givenName': model.givenName,
        'name': model.name,
        'latitude': model.latitude,
        'longitude': model.longitude,
        'iconIndex': model.iconIndex,
      };

  static String serialize(FavoriteModel model) =>
      json.encode(FavoriteModel.toMap(model));

  static Future<FavoriteModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 1),
      () => FavoriteModel.fromJson(jsonDecode(json)));

  static FavoriteModel deserializeFast(String json) =>
      FavoriteModel.fromJson(jsonDecode(json));
}
