import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/category_bloc/category_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/data/models/category.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';
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
  late User loggedUser;

  late Category selectedCategory;
  late List<Category> categories;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    categories = context.read<CategoryBloc>().state.categories!;
    selectedCategory =
        categories.firstWhere((category) => category.name == "All");
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: MenuDrawer(
        user: loggedUser,
      ),
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
              "Shop Items - 200",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      size: 16,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    controller: searchController,
                    onChanged: (value) {},
                    onSubmitted: (value) {},
                    autocorrect: true,
                  ),
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is LoadedCategories) {
                      return DropdownButton(
                        underline: const SizedBox.shrink(),
                        focusColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        value: selectedCategory,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: categories.map((Category category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (Category? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                      );
                    }

                    return const Text("No Categories");
                  },
                ),
              ],
            ),
            verticalSpace(
              height: 15,
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
    price: 29.9,
  ),
  Product(
    name: "Product name",
    imageUrl: "assets/images/fridge.jpg",
    images: [],
    price: 30,
  ),
];
