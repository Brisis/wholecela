import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/presentation/screens/wholesale_screen.dart';

class WholeSaleCard extends StatelessWidget {
  final Seller seller;
  const WholeSaleCard({
    super.key,
    required this.seller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            WholesaleScreen.route(seller: seller),
          );
        },
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
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: seller.imageUrl != null
                            ? DecorationImage(
                                //image: AssetImage(product.imageUrl!),
                                image: NetworkImage(
                                    "${AppUrls.SERVER_URL}/uploads/thumbnails/${seller.imageUrl}"),
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
                            seller.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          verticalSpace(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${seller.products.length} Products",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              horizontalSpace(
                                width: 8,
                              ),
                              const Icon(
                                Icons.brightness_1_rounded,
                                size: 5,
                              ),
                              horizontalSpace(
                                width: 8,
                              ),
                              Text(
                                "${getProductsCategories(seller.products)} Categories",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.store),
            ],
          ),
        ),
      ),
    );
  }
}

int getProductsCategories(List<Product> products) {
  var categories = [];
  for (var product in products) {
    categories.add(product.categoryId);
  }
  return categories.toSet().toList().length;
}
