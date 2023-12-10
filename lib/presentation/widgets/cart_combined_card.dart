import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/seller/seller_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';

class CartCombinedCard extends StatefulWidget {
  final Cart cart;
  const CartCombinedCard({
    super.key,
    required this.cart,
  });

  @override
  State<CartCombinedCard> createState() => _CartCombinedCardState();
}

class _CartCombinedCardState extends State<CartCombinedCard> {
  int cartValue = 5;

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
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/images/metro.jpg",
                        ),
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
                        const Text(
                          "Metropeach Brownee",
                          style: TextStyle(
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
                          "$cartValue items",
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
                    context
                        .read<SellerBloc>()
                        .add(LoadSeller(id: widget.cart.sellerId));
                    Navigator.push(
                      context,
                      CartScreen.route(sellerId: widget.cart.sellerId),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: () {},
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
