import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/core/config/http_handler.dart';

class CartItemProvider {
  Future<dynamic> addCartItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    try {
      Map body = {
        "cartId": cartId,
        "productId": productId,
        "quantity": quantity
      };

      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/cart-items"),
        body: json.encode(body),
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
      // throw ExceptionHandlers.getExceptionString(e);
    }
  }

  Future<dynamic> getCartItems({required String cartId}) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/cart-items/cart/$cartId"),
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
