part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderStateInitial extends OrderState {}

class OrderStateLoading extends OrderState {}

class OrderStateAdded extends OrderState {
  final String orderId;
  const OrderStateAdded({
    required this.orderId,
  });

  @override
  List<Object> get props => [orderId];

  @override
  bool? get stringify => true;
}

class OrderStateCreated extends OrderState {}

class LoadedOrder extends OrderState {
  final Order order;
  const LoadedOrder({
    required this.order,
  });

  @override
  List<Object> get props => [order];

  @override
  bool? get stringify => true;
}

class LoadedOrders extends OrderState {
  final List<Order> orders;
  const LoadedOrders({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];

  @override
  bool? get stringify => true;
}

class OrderStateError extends OrderState {
  final AppException? message;
  const OrderStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}
