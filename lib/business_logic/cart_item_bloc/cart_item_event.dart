part of 'cart_item_bloc.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

class LoadCartItems extends CartItemEvent {
  final String cartId;

  const LoadCartItems({
    required this.cartId,
  });
}
