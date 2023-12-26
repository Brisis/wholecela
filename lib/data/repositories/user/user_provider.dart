import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';

import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/core/config/http_handler.dart';
import 'package:wholecela/data/models/user.dart';

class UserProvider {
  Future<dynamic> updateUserDetails({
    required String token,
    required User user,
  }) async {
    try {
      Map body = {
        "name": user.name,
        "phone": user.phone,
        "street": user.street,
        "latlng": user.latlng,
        "locationId": user.locationId,
      };
      final response = await http.patch(
        Uri.parse("${AppUrls.SERVER_URL}/users/${user.id}/update"),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          'Authorization': 'Bearer $token',
        },
      );

      return HttpHandler.returnResponse(response);
    } on SocketException {
      throw const FetchDataException(message: "No Internet connection");
    } on TimeoutException {
      throw const ApiNotRespondingException(message: "Api not responding");
      // throw ExceptionHandlers.getExceptionString(e);
    }
  }

  Future<dynamic> updateUserImage({
    required String token,
    required String userId,
    required File image,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppUrls.SERVER_URL}/users/$userId/upload-image"),
      );

      request.headers.addAll(
        {
          "Access-Control-Allow-Origin": "*",
          'Authorization': 'Bearer $token',
        },
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          File(image.path).readAsBytesSync(),
          filename: image.path,
          contentType: MediaType('image', "png"),
        ),
      );

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      return HttpHandler.returnResponse(response);
    } on SocketException {
      throw const FetchDataException(message: "No Internet connection");
    } on TimeoutException {
      throw const ApiNotRespondingException(message: "Api not responding");
      // throw ExceptionHandlers.getExceptionString(e);
    }
  }
}
