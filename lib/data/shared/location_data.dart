// import 'dart:convert';

// import 'package:micasa/data/models/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocationData {
//   static saveUserLocation(Location location) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('location', jsonEncode(location));
//   }

//   static Future<Location> getSavedLocation() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, dynamic> json = jsonDecode(prefs.getString("location")!);
//     return Location.fromJson(json);
//   }

//   static void deleteSavedLocation() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove("location");
//   }
// }
