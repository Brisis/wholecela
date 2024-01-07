import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String id;
  final DateTime createdAt;
  final int quantity;
  final OrderModel order;
  final Product product;

  OrderItem({
    required this.id,
    required this.createdAt,
    required this.quantity,
    required this.order,
    required this.product,
  });

  OrderItem copyWith({
    String? id,
    DateTime? createdAt,
    int? quantity,
    OrderModel? order,
    Product? product,
  }) =>
      OrderItem(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        quantity: quantity ?? this.quantity,
        order: order ?? this.order,
        product: product ?? this.product,
      );

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        quantity: json["quantity"],
        order: OrderModel.fromJson(json["order"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "quantity": quantity,
        "order": order.toJson(),
        "product": product.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        quantity,
        order,
        product,
      ];

  @override
  bool? get stringify => true;
}

class OrderModel {
  final String id;
  final double totalPrice;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.createdAt,
  });

  OrderModel copyWith({
    String? id,
    double? totalPrice,
    DateTime? createdAt,
  }) =>
      OrderModel(
        id: id ?? this.id,
        totalPrice: totalPrice ?? this.totalPrice,
        createdAt: createdAt ?? this.createdAt,
      );

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        totalPrice: json["totalPrice"]?.toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalPrice": totalPrice,
        "createdAt": createdAt.toIso8601String(),
      };
}

class Product {
  final String id;
  final String title;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? title,
    double? price,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
      };
}
