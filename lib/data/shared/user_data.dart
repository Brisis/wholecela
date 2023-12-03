// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wholecela/data/models/user.dart';

// class UserData {
//   static saveUser(User user) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('user', jsonEncode(user));
//   }

//   static Future<User> getSavedUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, dynamic> json = jsonDecode(prefs.getString("user")!);
//     return User.fromJson(json);
//   }

//   static void deleteSavedUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove("user");
//   }
// }
