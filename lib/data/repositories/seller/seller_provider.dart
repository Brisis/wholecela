import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/core/config/http_handler.dart';

class SellerProvider {
  Future<dynamic> getSellers() async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/users?role=SELLER"),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      return HttpHandler.returnResponse(response);
    } on SocketException {
      throw const FetchDataException(message: "No Internet connection");
    } on TimeoutException {
      throw const ApiNotRespondingException(message: "Api not responding");
    }
  }
}
