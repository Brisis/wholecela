part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartStateInitial extends CartState {}

class CartStateLoading extends CartState {}

class LoadedCart extends CartState {
  final Cart cart;
  const LoadedCart({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];

  @override
  bool? get stringify => true;
}

class LoadedCarts extends CartState {
  final List<Cart> carts;
  const LoadedCarts({
    required this.carts,
  });

  @override
  List<Object> get props => [carts];

  @override
  bool? get stringify => true;
}

class CartStateError extends CartState {
  final AppException? message;
  const CartStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

extension GetCarts on CartState {
  List<Cart>? get carts {
    final cls = this;
    if (cls is LoadedCarts) {
      return cls.carts;
    } else {
      return null;
    }
  }
}

extension GetCart on CartState {
  Cart? get cart {
    final cls = this;
    if (cls is LoadedCart) {
      return cls.cart;
    } else {
      return null;
    }
  }
}
