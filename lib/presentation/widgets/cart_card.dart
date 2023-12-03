import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';

class CartCard extends StatefulWidget {
  const CartCard({super.key});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int cartValue = 2;

  void _incrementValue() {
    if (cartValue < 10) {
      setState(() {
        cartValue++;
      });
    }
  }

  void _decrementValue() {
    if (cartValue > 1) {
      setState(() {
        cartValue--;
      });
    }
  }

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
                          "assets/images/product.jpg",
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
                          "Product name",
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
                  onPressed: _decrementValue,
                  icon: const Icon(Icons.remove),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: _incrementValue,
                  icon: const Icon(Icons.add),
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
