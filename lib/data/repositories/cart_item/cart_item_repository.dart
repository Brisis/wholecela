import 'package:wholecela/data/models/cart_item.dart';
import 'package:wholecela/data/repositories/cart_item/cart_item_provider.dart';

class CartItemRepository {
  final CartItemProvider cartItemProvider;
  const CartItemRepository({required this.cartItemProvider});

  Future<List<CartItem>> addCartItem({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    final response = await cartItemProvider.addCartItem(
      cartId: cartId,
      productId: productId,
      quantity: quantity,
    );

    return (response as List<dynamic>)
        .map(
          (i) => CartItem.fromJson(i),
        )
        .toList();
  }

  Future<List<CartItem>> getCartItems({required String cartId}) async {
    final response = await cartItemProvider.getCartItems(cartId: cartId);

    return (response as List<dynamic>)
        .map(
          (i) => CartItem.fromJson(i),
        )
        .toList();
  }

  Future<List<CartItem>> deleteCartItem({required String cartItemId}) async {
    final response = await cartItemProvider.deleteCartItem(
      cartItemId: cartItemId,
    );

    return (response as List<dynamic>)
        .map(
          (i) => CartItem.fromJson(i),
        )
        .toList();
  }
}
