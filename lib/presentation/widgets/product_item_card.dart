import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/data/models/product.dart';

class ProductItemCard extends StatelessWidget {
  final Product product;

  const ProductItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              //height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                image: product.imageUrl != null
                    ? DecorationImage(
                        //image: AssetImage(product.imageUrl!),
                        image: NetworkImage(
                            "${AppUrls.SERVER_URL}/thumbnails/${product.imageUrl}"),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage("assets/images/product.jpg"),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    color: kBlackColor,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                verticalSpace(),
                Text(
                  "${product.quantity} left in stock",
                  style: const TextStyle(
                    color: kBlackColor,
                    fontSize: 13,
                  ),
                ),
                verticalSpace(),
                Text(
                  formatPrice(product.price),
                  style: const TextStyle(
                    color: kBlackColor,
                    fontSize: kMediumTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
