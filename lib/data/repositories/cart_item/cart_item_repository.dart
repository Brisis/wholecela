import 'package:wholecela/data/models/cart_item.dart';
import 'package:wholecela/data/repositories/cart_item/cart_item_provider.dart';

class CartItemRepository {
  final CartItemProvider cartItemProvider;
  const CartItemRepository({required this.cartItemProvider});

  Future<List<CartItem>> getCartItems({required String cartId}) async {
    final response = await cartItemProvider.getCartItems(cartId: cartId);

    return (response as List<dynamic>)
        .map(
          (i) => CartItem.fromJson(i),
        )
        .toList();
  }
}
