import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/screens/product_screen.dart';

class ProductItemCard extends StatelessWidget {
  final Product product;

  const ProductItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          ProductScreen.route(),
        );
      },
      child: Container(
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
                          image: AssetImage(product.imageUrl!),
                          // image: NetworkImage(
                          //     "${AppUrls.SERVER_URL}/uploads/thumbnails/${product.imageUrl}"),
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
                    product.name,
                    style: const TextStyle(
                      color: kBlackColor,
                      fontSize: kMediumTextSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  verticalSpace(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     const Icon(
                  //       Icons.room_outlined,
                  //       color: kBlackFaded,
                  //       size: 15,
                  //     ),
                  //     Expanded(
                  //       child: Text(
                  //         product.locationName,
                  //         style: const TextStyle(
                  //           color: kBlackFaded,
                  //           fontSize: kNormalTextSize,
                  //         ),
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 1,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  verticalSpace(),
                  Text(
                    "\$${product.price}",
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
      ),
    );
  }
}
