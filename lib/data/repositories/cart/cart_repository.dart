import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/data/repositories/cart/cart_provider.dart';

class CartRepository {
  final CartProvider cartProvider;
  const CartRepository({required this.cartProvider});

  Future<Cart> createCart({
    required String userId,
    required String sellerId,
  }) async {
    final response = await cartProvider.createCart(
      userId: userId,
      sellerId: sellerId,
    );

    return Cart.fromJson(response);
  }

  Future<List<Cart>> getCarts({required String userId}) async {
    final response = await cartProvider.getCarts(userId: userId);

    return (response as List<dynamic>)
        .map(
          (i) => Cart.fromJson(i),
        )
        .toList();
  }

  Future<Cart> getUserCartBySeller({
    required String userId,
    required String sellerId,
  }) async {
    final response = await cartProvider.getUserCartBySeller(
      userId: userId,
      sellerId: sellerId,
    );

    return Cart.fromJson(response);
  }
}
