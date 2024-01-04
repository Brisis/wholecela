import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';

import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/core/config/http_handler.dart';
import 'package:wholecela/data/models/product.dart';

class ProductProvider {
  Future<dynamic> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/products"),
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

  Future<dynamic> getProduct({required String id}) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/products/$id"),
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

  Future<dynamic> addProduct({
    required String title,
    required String categoryId,
    required String ownerId,
    required double price,
    required int quantity,
  }) async {
    try {
      Map body = {
        "title": title,
        "categoryId": categoryId,
        "ownerId": ownerId,
        "price": price,
        "quantity": quantity
      };

      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/products"),
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
        Uri.parse("${AppUrls.SERVER_URL}/products/${product.id}"),
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
        Uri.parse("${AppUrls.SERVER_URL}/products/$productId/update-colors"),
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
        Uri.parse("${AppUrls.SERVER_URL}/products/$productId/upload-image"),
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
