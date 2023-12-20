import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/cart_item.dart';
import 'package:wholecela/data/repositories/cart_item/cart_item_repository.dart';

part 'cart_item_event.dart';
part 'cart_item_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final CartItemRepository cartItemRepository;
  CartItemBloc({
    required this.cartItemRepository,
  }) : super(CartItemStateInitial()) {
    on<AddCartItem>((event, emit) async {
      emit(CartItemStateLoading());
      try {
        final cartItems = await cartItemRepository.addCartItem(
          cartId: event.cartId,
          productId: event.productId,
          quantity: event.quantity,
        );

        emit(CartItemStateChanged());

        emit(LoadedCartItems(cartItems: cartItems));
      } on AppException catch (e) {
        emit(
          CartItemStateError(
            message: e,
          ),
        );
      }
    });

    on<DeleteCartItem>((event, emit) async {
      emit(CartItemStateLoading());
      try {
        final cartItems = await cartItemRepository.deleteCartItem(
          cartItemId: event.cartItemId,
        );

        emit(CartItemStateDeleted());

        emit(LoadedCartItems(cartItems: cartItems));
      } on AppException catch (e) {
        emit(
          CartItemStateError(
            message: e,
          ),
        );
      }
    });

    on<LoadCartItems>((event, emit) async {
      emit(CartItemStateLoading());
      try {
        final cartItems = await cartItemRepository.getCartItems(
          cartId: event.cartId,
        );

        emit(LoadedCartItems(cartItems: cartItems));
      } on AppException catch (e) {
        emit(
          CartItemStateError(
            message: e,
          ),
        );
      }
    });
  }
}
