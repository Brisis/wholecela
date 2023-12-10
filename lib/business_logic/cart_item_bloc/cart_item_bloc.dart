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
