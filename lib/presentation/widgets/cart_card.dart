import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/cart_item_bloc/cart_item_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/data/models/cart_item.dart';

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  const CartCard({
    super.key,
    required this.cartItem,
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
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: cartItem.product.imageUrl != null
                          ? DecorationImage(
                              //image: AssetImage(product.imageUrl!),
                              image: NetworkImage(
                                  "${AppUrls.SERVER_URL}/thumbnails/${cartItem.product.imageUrl}"),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage("assets/images/product.jpg"),
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
                          cartItem.product.title,
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
                          "${cartItem.quantity} items x (${formatPrice(cartItem.product.price)})",
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
            horizontalSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    var qty = cartItem.quantity - 1;
                    context.read<CartItemBloc>().add(
                          AddCartItem(
                            cartId: cartItem.cartId,
                            productId: cartItem.product.id,
                            quantity: qty,
                          ),
                        );
                  },
                  icon: const Icon(Icons.remove),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: () {
                    var qty = cartItem.quantity + 1;
                    context.read<CartItemBloc>().add(
                          AddCartItem(
                            cartId: cartItem.cartId,
                            productId: cartItem.product.id,
                            quantity: qty,
                          ),
                        );
                  },
                  icon: const Icon(Icons.add),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: () {
                    context
                        .read<CartItemBloc>()
                        .add(DeleteCartItem(cartItemId: cartItem.id));
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
