import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/widgets/product_item_card.dart';

class WholesaleScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const WholesaleScreen(),
    );
  }

  const WholesaleScreen({super.key});

  @override
  State<WholesaleScreen> createState() => _WholesaleScreenState();
}

class _WholesaleScreenState extends State<WholesaleScreen> {
  // Initial Selected Value
  String dropdownvalue = 'All';

  // List of items in our dropdown menu
  var items = [
    'All',
    'Groceries',
    'Hardware',
    'Toys',
    'Electronics',
    'Babyware',
  ];

  TextEditingController controller = TextEditingController();

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
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/metro.jpg",
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "200 products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: CupertinoSearchTextField(
                    controller: controller,
                    onChanged: (value) {},
                    onSubmitted: (value) {},
                    autocorrect: true,
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
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
              height: 30,
            ),
            Expanded(
              child: GridView.count(
                //shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 1.6 / 2,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  products.length,
                  (index) => ProductItemCard(
                    product: products[index],
                  ),
                ),
              ),
            ),
          ],
        ),
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

List<Product> products = [
  Product(
    name: "Product name",
    imageUrl: "assets/images/fridge.jpg",
    images: [],
    price: 30,
  ),
  Product(
    name: "Product name",
    images: [],
    price: 30,
  ),
  Product(
    name: "Product name",
    imageUrl: "assets/images/fridge.jpg",
    images: [],
    price: 30,
  ),
];
