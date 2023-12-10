import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/core/config/exception_handlers.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/data/repositories/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  CartBloc({
    required this.cartRepository,
  }) : super(CartStateInitial()) {
    on<LoadCarts>((event, emit) async {
      emit(CartStateLoading());
      try {
        final carts = await cartRepository.getCarts(
          userId: event.userId,
        );

        emit(LoadedCarts(carts: carts));
      } on AppException catch (e) {
        emit(
          CartStateError(
            message: e,
          ),
        );
      }
    });

    on<LoadCart>((event, emit) async {
      emit(CartStateLoading());
      try {
        final cart = await cartRepository.getUserCartBySeller(
          userId: event.userId,
          sellerId: event.sellerId,
        );

        emit(LoadedCart(cart: cart));
      } on AppException catch (e) {
        emit(
          CartStateError(
            message: e,
          ),
        );
      }
    });
  }
}
