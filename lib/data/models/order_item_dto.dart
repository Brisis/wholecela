import 'dart:convert';

class OrderItemDto {
  final int quantity;
  final String productId;
  final String orderId;

  OrderItemDto({
    required this.quantity,
    required this.productId,
    required this.orderId,
  });

  factory OrderItemDto.fromRawJson(String str) =>
      OrderItemDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItemDto.fromJson(Map<String, dynamic> json) => OrderItemDto(
        quantity: json["quantity"],
        productId: json["productId"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "productId": productId,
        "orderId": orderId,
      };
}
