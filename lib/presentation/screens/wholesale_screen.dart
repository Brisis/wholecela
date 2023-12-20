import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/cart_bloc/cart_bloc.dart';
import 'package:wholecela/business_logic/category_bloc/category_bloc.dart';
import 'package:wholecela/business_logic/seller/seller_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/data/models/category.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/screens/product_screen.dart';
import 'package:wholecela/presentation/utils/loaders/screen_loading.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';
import 'package:wholecela/presentation/widgets/product_item_card.dart';

class WholesaleScreen extends StatefulWidget {
  final String sellerId;
  static Route route({required String sellerId}) {
    return MaterialPageRoute(
      builder: (context) => WholesaleScreen(
        sellerId: sellerId,
      ),
    );
  }

  const WholesaleScreen({
    super.key,
    required this.sellerId,
  });

  @override
  State<WholesaleScreen> createState() => _WholesaleScreenState();
}

class _WholesaleScreenState extends State<WholesaleScreen> {
  late User loggedUser;

  late Category? selectedCategory;
  late List<Category> categories;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    categories = context.read<CategoryBloc>().state.categories!;
    if (categories.isNotEmpty) {
      selectedCategory =
          categories.firstWhere((category) => category.name == "All");
    }

    if (categories.isEmpty) {
      selectedCategory = null;
    }

    context.read<SellerBloc>().add(LoadSeller(id: widget.sellerId));

    context
        .read<CartBloc>()
        .add(LoadCart(userId: loggedUser.id, sellerId: widget.sellerId));
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        if (state is LoadedSeller) {
          Seller seller = state.seller;
          List<Product> products = seller.products;

          return Scaffold(
            backgroundColor: kBackgroundColor,
            drawer: MenuDrawer(
              user: loggedUser,
            ),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(
                seller.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: AvatarImage(
                    imageUrl: seller.imageUrl,
                    isSeller: true,
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<SellerBloc>().add(LoadSeller(id: seller.id));
                context.read<CategoryBloc>().add(LoadCategories());
                context
                    .read<CartBloc>()
                    .add(LoadCart(userId: loggedUser.id, sellerId: seller.id));
              },
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${products.length} Products",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<SellerBloc>()
                                    .add(LoadSeller(id: seller.id));
                                context
                                    .read<CategoryBloc>()
                                    .add(LoadCategories());
                                context.read<CartBloc>().add(LoadCart(
                                    userId: loggedUser.id,
                                    sellerId: seller.id));
                              },
                              icon: const Icon(
                                Icons.refresh,
                              ),
                            ),
                            horizontalSpace(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                              return selectedCategory != null
                                  ? DropdownButton(
                                      underline: const SizedBox.shrink(),
                                      focusColor: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      value: selectedCategory,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items:
                                          categories.map((Category category) {
                                        return DropdownMenuItem(
                                          value: category,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
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
                                    )
                                  : const Text("No Categories");
                            }

                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    verticalSpace(
                      height: 15,
                    ),
                    products.isNotEmpty
                        ? Expanded(
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              childAspectRatio: 1.6 / 2,
                              //physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                products.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      ProductScreen.route(
                                        sellerId: seller.id,
                                        productId: products[index].id,
                                      ),
                                    );
                                  },
                                  child: ProductItemCard(
                                    product: products[index],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: Text(
                                "Wholesale is Empty",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            floatingActionButton: BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) => current.props != previous.props,
              builder: (context, state) {
                if (state is LoadedCart) {
                  Cart cart = state.cart;

                  return FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CartScreen.route(sellerId: seller.id),
                      );
                    },
                    tooltip: 'My Cart',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.shopping_cart),
                        horizontalSpace(width: 3),
                        Text(
                          cart.cartItems.length.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is CartStateCreated) {
                  return FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CartScreen.route(sellerId: seller.id),
                      );
                    },
                    tooltip: 'My Cart',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.shopping_cart),
                        horizontalSpace(width: 3),
                        const Text(
                          "0",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is CartStateError) {
                  return const FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed: null,
                    tooltip: 'My Cart',
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: kBlackFaded,
                    ),
                  );
                }

                if (state is CartStateLoading) {
                  return const FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed: null,
                    tooltip: 'My Cart',
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  );
                }

                return const FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: null,
                  tooltip: 'My Cart',
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: kBlackFaded,
                  ),
                );
              },
            ),
          );
        }

        return const ScreenViewLoading();
      },
    );
  }
}
