part of 'cart_item_bloc.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

class AddCartItem extends CartItemEvent {
  final String cartId;
  final String productId;
  final int quantity;

  const AddCartItem({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });
}

class DeleteCartItem extends CartItemEvent {
  final String cartItemId;

  const DeleteCartItem({
    required this.cartItemId,
  });
}

class LoadCartItems extends CartItemEvent {
  final String cartId;

  const LoadCartItems({
    required this.cartId,
  });
}
