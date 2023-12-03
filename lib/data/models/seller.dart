import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:wholecela/data/models/product.dart';

class Seller extends Equatable {
  final String id;
  final String name;
  final String? phone;
  final String? imageUrl;
  final String role;
  final String? locationId;
  final String? street;
  final String? latlng;
  final String email;
  final List<Product> products;

  const Seller({
    required this.id,
    required this.name,
    this.phone,
    this.imageUrl,
    required this.role,
    this.locationId,
    this.street,
    this.latlng,
    required this.email,
    required this.products,
  });

  Seller copyWith({
    String? name,
    String? phone,
    String? imageUrl,
    String? locationId,
    String? street,
    String? latlng,
  }) =>
      Seller(
        id: id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        imageUrl: imageUrl ?? this.imageUrl,
        role: role,
        locationId: locationId ?? this.locationId,
        street: street ?? this.street,
        latlng: latlng ?? this.latlng,
        email: email,
        products: products,
      );

  factory Seller.fromRawJson(String str) => Seller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"],
        phone: json["phone"] == null ? null : json["phone"] as String,
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"] as String,
        role: json["role"],
        locationId:
            json["locationId"] == null ? null : json["locationId"] as String,
        street: json["street"] == null ? null : json["street"] as String,
        latlng: json["latlng"] == null ? null : json["latlng"] as String,
        email: json["email"],
        products: (json["products"] as List<dynamic>)
            .map((i) => Product.fromJson(i))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "imageUrl": imageUrl,
        "role": role,
        "locationId": locationId,
        "street": street,
        "latlng": latlng,
        "email": email,
        "products": products,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        imageUrl,
        role,
        locationId,
        street,
        latlng,
        email,
        products,
      ];
}
