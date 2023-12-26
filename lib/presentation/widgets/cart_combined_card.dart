import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/cart_bloc/cart_bloc.dart';
import 'package:wholecela/business_logic/seller/seller_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/presentation/screens/wholesale_screen.dart';

class CartCombinedCard extends StatelessWidget {
  final Cart cart;
  const CartCombinedCard({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    WholesaleScreen.route(sellerId: cart.sellerId),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: cart.seller.imageUrl != null
                            ? DecorationImage(
                                //image: AssetImage(product.imageUrl!),
                                image: NetworkImage(
                                    "${AppUrls.SERVER_URL}/thumbnails/${cart.seller.imageUrl}"),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage("assets/images/shop.png"),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    horizontalSpace(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart.seller.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(
                            height: 10,
                          ),
                          Text(
                            "${cart.cartItems.length} items",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context
                        .read<SellerBloc>()
                        .add(LoadSeller(id: cart.sellerId));
                    Navigator.push(
                      context,
                      CartScreen.route(sellerId: cart.sellerId),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(DeleteCart(cartId: cart.id));
                  },
                  icon: const Icon(
                    Icons.delete_outline_sharp,
                    color: kWarningColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
