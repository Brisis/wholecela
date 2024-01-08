import 'dart:convert';

class Order {
  final String id;
  final DateTime createdAt;
  final String status;
  final double totalPrice;
  final Location location;
  final UserModel user;
  final List<OrderItemModel> orderItems;

  Order({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.totalPrice,
    required this.location,
    required this.user,
    required this.orderItems,
  });

  Order copyWith({
    String? id,
    DateTime? createdAt,
    String? status,
    double? totalPrice,
    Location? location,
    UserModel? user,
    List<OrderItemModel>? orderItems,
  }) =>
      Order(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        totalPrice: totalPrice ?? this.totalPrice,
        location: location ?? this.location,
        user: user ?? this.user,
        orderItems: orderItems ?? this.orderItems,
      );

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        status: json["status"],
        totalPrice: json["totalPrice"]?.toDouble(),
        location: Location.fromJson(json["location"]),
        user: UserModel.fromJson(json["user"]),
        orderItems: List<OrderItemModel>.from(
            json["orderItems"].map((x) => OrderItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "status": status,
        "totalPrice": totalPrice,
        "location": location.toJson(),
        "user": user.toJson(),
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class Location {
  final String id;
  final String name;
  final String city;

  Location({
    required this.id,
    required this.name,
    required this.city,
  });

  Location copyWith({
    String? id,
    String? name,
    String? city,
  }) =>
      Location(
        id: id ?? this.id,
        name: name ?? this.name,
        city: city ?? this.city,
      );

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
      };
}

class OrderItemModel {
  final String id;
  final int quantity;
  final DateTime createdAt;
  final Product product;

  OrderItemModel({
    required this.id,
    required this.quantity,
    required this.createdAt,
    required this.product,
  });

  OrderItemModel copyWith({
    String? id,
    int? quantity,
    DateTime? createdAt,
    Product? product,
  }) =>
      OrderItemModel(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        createdAt: createdAt ?? this.createdAt,
        product: product ?? this.product,
      );

  factory OrderItemModel.fromRawJson(String str) =>
      OrderItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json["id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["createdAt"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "createdAt": createdAt.toIso8601String(),
        "product": product.toJson(),
      };
}

class Product {
  final String id;
  final String title;
  final double price;
  final String? imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.imageUrl,
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
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "imageUrl": imageUrl,
      };
}

class UserModel {
  final String name;
  final String phone;

  UserModel({
    required this.name,
    required this.phone,
  });

  UserModel copyWith({
    String? name,
    String? phone,
  }) =>
      UserModel(
        name: name ?? this.name,
        phone: phone ?? this.phone,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };
}
