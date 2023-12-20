import 'dart:convert';

import 'package:wholecela/core/extensions/convert_double.dart';

class Cart {
  final String id;
  final String userId;
  final String sellerId;
  final List<CartItemModel> cartItems;
  final CartSeller seller;
  final double total;

  Cart({
    required this.id,
    required this.userId,
    required this.sellerId,
    required this.cartItems,
    required this.seller,
    required this.total,
  });

  Cart copyWith({
    String? id,
    String? userId,
    String? sellerId,
    List<CartItemModel>? cartItems,
    CartSeller? seller,
    double? total,
  }) =>
      Cart(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        sellerId: sellerId ?? this.sellerId,
        cartItems: cartItems ?? this.cartItems,
        seller: seller ?? this.seller,
        total: total ?? this.total,
      );

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["userId"],
        sellerId: json["sellerId"],
        cartItems: (json["cartItems"] as List<dynamic>)
            .map(
              (i) => CartItemModel.fromJson(i),
            )
            .toList(),
        seller: CartSeller.fromJson(json["seller"]),
        total: toDouble(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "sellerId": sellerId,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "seller": seller.toJson(),
        "total": total,
      };
}

class CartItemModel {
  final String id;
  final int quantity;
  final String cartId;
  final String productId;

  CartItemModel({
    required this.id,
    required this.quantity,
    required this.cartId,
    required this.productId,
  });

  CartItemModel copyWith({
    String? id,
    int? quantity,
    String? cartId,
    String? productId,
  }) =>
      CartItemModel(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        cartId: cartId ?? this.cartId,
        productId: productId ?? this.productId,
      );

  factory CartItemModel.fromRawJson(String str) =>
      CartItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json["id"],
        quantity: json["quantity"],
        cartId: json["cartId"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "cartId": cartId,
        "productId": productId,
      };
}

class CartSeller {
  final String name;
  final String? imageUrl;

  CartSeller({
    required this.name,
    this.imageUrl,
  });

  CartSeller copyWith({
    String? name,
    String? imageUrl,
  }) =>
      CartSeller(
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory CartSeller.fromRawJson(String str) =>
      CartSeller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartSeller.fromJson(Map<String, dynamic> json) => CartSeller(
        name: json["name"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
      };
}
