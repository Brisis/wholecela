import 'dart:convert';

import 'package:wholecela/core/extensions/convert_double.dart';

class CartItem {
  final String id;
  final int quantity;
  final String cartId;
  final CartItemProduct product;

  CartItem({
    required this.id,
    required this.quantity,
    required this.cartId,
    required this.product,
  });

  CartItem copyWith({
    String? id,
    int? quantity,
    String? cartId,
    CartItemProduct? product,
  }) =>
      CartItem(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        cartId: cartId ?? this.cartId,
        product: product ?? this.product,
      );

  factory CartItem.fromRawJson(String str) =>
      CartItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        quantity: json["quantity"],
        cartId: json["cartId"],
        product: CartItemProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "cartId": cartId,
        "product": product.toJson(),
      };
}

class CartItemProduct {
  final String id;
  final String title;
  final double price;
  final String? imageUrl;

  CartItemProduct({
    required this.id,
    required this.title,
    required this.price,
    this.imageUrl,
  });

  CartItemProduct copyWith({
    String? id,
    String? title,
    double? price,
    String? imageUrl,
  }) =>
      CartItemProduct(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory CartItemProduct.fromRawJson(String str) =>
      CartItemProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItemProduct.fromJson(Map<String, dynamic> json) =>
      CartItemProduct(
        id: json["id"],
        title: json["title"],
        price: toDouble(json["price"]),
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "imageUrl": imageUrl,
      };
}
