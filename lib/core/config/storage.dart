import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

// to save token in local storage
void saveAuthToken(String token) async {
  await storage.write(key: 'token', value: token);
}

void saveFavourites(List<int> favourites) async {
  await storage.write(key: 'favourites', value: jsonEncode(favourites));
}

// to delete token in local storage
void deleteAuthToken() async {
  await storage.delete(key: 'token');
}

Future<String?> getAuthToken() async {
// to get token from local storage
  final token = await storage.read(key: 'token');
  return token;
}