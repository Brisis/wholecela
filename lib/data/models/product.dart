import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wholecela/core/extensions/convert_double.dart';
import 'package:wholecela/data/models/color.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String? imageUrl;
  final String? description;
  final int quantity;
  final double price;
  final bool authenticity;
  final bool returnPolicy;
  final bool warranty;
  final String categoryId;
  final List<ColorModel> colors;

  const Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.quantity,
    required this.price,
    required this.authenticity,
    required this.returnPolicy,
    required this.warranty,
    required this.categoryId,
    required this.colors,
  });

  Product copyWith({
    String? title,
    String? imageUrl,
    String? description,
    int? quantity,
    double? price,
    bool? authenticity,
    bool? returnPolicy,
    bool? warranty,
    String? categoryId,
    List<ColorModel>? colors,
  }) =>
      Product(
        id: id,
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        authenticity: authenticity ?? this.authenticity,
        returnPolicy: returnPolicy ?? this.returnPolicy,
        warranty: warranty ?? this.warranty,
        categoryId: categoryId ?? this.categoryId,
        colors: colors ?? this.colors,
      );

  String toRawJson() => json.encode(toJson());

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        imageUrl = json["imageUrl"] == null ? null : json["imageUrl"] as String,
        description =
            json["description"] == null ? null : json["description"] as String,
        quantity = json["quantity"] as int,
        price = toDouble(json["price"]),
        authenticity = json["authenticity"],
        returnPolicy = json["returnPolicy"],
        warranty = json["warranty"],
        categoryId = json["categoryId"],
        colors = json["colors"] == null
            ? []
            : (json["colors"] as List<dynamic>)
                .map((i) => ColorModel.fromJson(i))
                .toList();

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "description": description,
        "quantity": quantity,
        "price": price,
        "authenticity": authenticity,
        "returnPolicy": returnPolicy,
        "warranty": warranty,
        "categoryId": categoryId,
        "colors": colors,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        description,
        quantity,
        price,
        authenticity,
        returnPolicy,
        warranty,
        categoryId,
        colors,
      ];

  @override
  bool? get stringify => true;
}
