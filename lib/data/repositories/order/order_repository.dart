import 'package:wholecela/data/models/order.dart';
import 'package:wholecela/data/models/order_item.dart';
import 'package:wholecela/data/repositories/order/order_provider.dart';

class OrderRepository {
  final OrderProvider orderProvider;
  const OrderRepository({required this.orderProvider});

  Future<List<Order>> getOrders({
    required String userId,
  }) async {
    final response = await orderProvider.getOrders(
      userId: userId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => Order.fromJson(i),
        )
        .toList();
  }

  Future<Order> getOrder({
    required String id,
  }) async {
    final response = await orderProvider.getOrder(
      id: id,
    );

    return Order.fromJson(response);
  }

  Future<Order> addOrder({
    required String status,
    required double totalPrice,
    required String userId,
    required String locationId,
  }) async {
    final response = await orderProvider.addOrder(
      status: status,
      totalPrice: totalPrice,
      userId: userId,
      locationId: locationId,
    );

    return Order.fromJson(response);
  }

  Future<OrderItem> addOrderItem({
    required int quantity,
    required String productId,
    required String orderId,
  }) async {
    final response = await orderProvider.addOrderItem(
      quantity: quantity,
      productId: productId,
      orderId: orderId,
    );

    return OrderItem.fromJson(response);
  }
  // Future<order> updateorderDetails({
  //   required order order,
  // }) async {
  //   final response = await orderProvider.updateUserDetails(
  //     order: order,
  //   );

  //   return order.fromJson(response);
  // }

  // Future<order> updateorderImage({
  //   required String orderId,
  //   required File image,
  // }) async {
  //   final response = await orderProvider.updateorderImage(
  //     orderId: orderId,
  //     image: image,
  //   );

  //   return order.fromJson(response);
  // }
}
