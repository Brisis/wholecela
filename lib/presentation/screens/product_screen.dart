import 'package:flutter/material.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/screens/wholesale_screen.dart';

class ProductScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const ProductScreen(),
    );
  }

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // Initial Selected Value
  String dropdownvalue = 'Any';

  // List of items in our dropdown menu
  var items = [
    'Any',
    'Green',
    'Blue',
    'Yellow',
    'Black',
    'Red',
  ];

  Product product = Product(
    name: "Product name",
    imageUrl: "assets/images/fridge.jpg",
    images: [],
    price: 30,
  );

  TextEditingController controller = TextEditingController();
  int cartValue = 1;

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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Metropeach Brownee",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                WholesaleScreen.route(),
              );
            },
            icon: const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/metro.jpg",
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              color: kWhiteColor,
              image: DecorationImage(
                image: AssetImage(product.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          verticalSpace(height: 15),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Product name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(height: 15),
                const Text(
                  "A ribbon or corner banner is usually used to highlight a particular Card, Icon or any other widget to make them stand out from others in a group.",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                verticalSpace(height: 15),
                const Text(
                  "\$30.00",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Product Color: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DropdownButton(
                      underline: const SizedBox.shrink(),
                      focusColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              items,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                verticalSpace(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "12 left in stock",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                verticalSpace(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _decrementValue,
                      icon: const Icon(
                        Icons.remove,
                      ),
                    ),
                    horizontalSpace(width: 30),
                    Text(
                      "$cartValue",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    horizontalSpace(width: 30),
                    IconButton(
                      onPressed: _incrementValue,
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
                verticalSpace(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Add to Cart",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            CartScreen.route(),
          );
        },
        tooltip: 'My Cart',
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.shopping_basket),
            Text(
              "12",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
