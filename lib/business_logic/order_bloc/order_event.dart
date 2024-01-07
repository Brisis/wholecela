part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrder extends OrderEvent {
  final String id;

  const LoadOrder({
    required this.id,
  });
}

class LoadOrders extends OrderEvent {
  final String userId;

  const LoadOrders({
    required this.userId,
  });
}

class AddOrder extends OrderEvent {
  final String status;
  final double totalPrice;
  final String userId;
  final String locationId;

  const AddOrder({
    required this.status,
    required this.totalPrice,
    required this.userId,
    required this.locationId,
  });
}

class AddOrderItems extends OrderEvent {
  final List<OrderItemDto> orderItems;

  const AddOrderItems({
    required this.orderItems,
  });
}

class OrderUpdateDetails implements OrderEvent {
  final Order order;

  const OrderUpdateDetails({
    required this.order,
  });

  @override
  List<Object> get props => [order];

  @override
  bool? get stringify => true;
}

class OrderUpdateImage implements OrderEvent {
  final Order order;

  const OrderUpdateImage({
    required this.order,
  });

  @override
  List<Object> get props => [order];

  @override
  bool? get stringify => true;
}

class DeleteOrder extends OrderEvent {
  final String id;

  const DeleteOrder({
    required this.id,
  });
}
