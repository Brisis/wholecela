part of 'cart_item_bloc.dart';

abstract class CartItemState extends Equatable {
  const CartItemState();

  @override
  List<Object> get props => [];
}

final class CartItemStateInitial extends CartItemState {}

class CartItemStateLoading extends CartItemState {}

class LoadedCartItems extends CartItemState {
  final List<CartItem> cartItems;
  const LoadedCartItems({
    required this.cartItems,
  });

  @override
  List<Object> get props => [cartItems];

  @override
  bool? get stringify => true;
}

class CartItemStateError extends CartItemState {
  final AppException? message;
  const CartItemStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

// Extract user from UserState
extension GetCartItems on CartItemState {
  List<CartItem>? get cartItems {
    final cls = this;
    if (cls is LoadedCartItems) {
      return cls.cartItems;
    } else {
      return null;
    }
  }
}
