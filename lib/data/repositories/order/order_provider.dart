import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';

import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/core/config/http_handler.dart';
import 'package:wholecela/data/models/product.dart';

class OrderProvider {
  Future<dynamic> getOrders({
    required String userId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/orders/user/$userId"),
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

  Future<dynamic> getOrder({required String id}) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/orders/$id"),
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

  Future<dynamic> addOrder({
    required String status,
    required double totalPrice,
    required String userId,
    required String locationId,
  }) async {
    try {
      Map body = {
        "status": status,
        "totalPrice": totalPrice,
        "userId": userId,
        "locationId": locationId
      };

      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/orders"),
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

  Future<dynamic> addOrderItem({
    required int quantity,
    required String productId,
    required String orderId,
  }) async {
    try {
      Map body = {
        "quantity": quantity,
        "productId": productId,
        "orderId": orderId
      };

      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/order-items"),
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

  Future<dynamic> updateUserDetails({
    required Product product,
  }) async {
    try {
      Map body = {
        "title": product.title,
        "categoryId": product.categoryId,
        "description": product.description,
        "price": product.price,
        "quantity": product.quantity,
      };
      final response = await http.patch(
        Uri.parse("${AppUrls.SERVER_URL}/orders/${product.id}"),
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

  Future<dynamic> updateProductColors({
    required String productId,
    required List<String> colors,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse("${AppUrls.SERVER_URL}/orders/$productId/update-colors"),
        body: json.encode(colors),
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

  Future<dynamic> updateProductImage({
    required String productId,
    required File image,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppUrls.SERVER_URL}/orders/$productId/upload-image"),
      );

      request.headers.addAll(
        {
          "Access-Control-Allow-Origin": "*",
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
