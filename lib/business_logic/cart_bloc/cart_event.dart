part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  final String userId;
  final String sellerId;

  const LoadCart({
    required this.userId,
    required this.sellerId,
  });
}

class LoadCarts extends CartEvent {
  final String userId;

  const LoadCarts({
    required this.userId,
  });
}
