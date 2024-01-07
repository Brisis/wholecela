import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/cart_bloc/cart_bloc.dart';
import 'package:wholecela/business_logic/cart_item_bloc/cart_item_bloc.dart';
import 'package:wholecela/business_logic/color_bloc/color_bloc.dart';
import 'package:wholecela/business_logic/product_bloc/product_bloc.dart';
import 'package:wholecela/business_logic/seller_bloc/seller_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/core/extensions/to_hex_color.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/data/models/color.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/screens/wholesale_screen.dart';
import 'package:wholecela/presentation/utils/loaders/screen_loading.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';

class ProductScreen extends StatefulWidget {
  final String sellerId;
  final String productId;
  static Route route({required String sellerId, required String productId}) {
    return MaterialPageRoute(
      builder: (context) => ProductScreen(
        sellerId: sellerId,
        productId: productId,
      ),
    );
  }

  const ProductScreen({
    super.key,
    required this.sellerId,
    required this.productId,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int cartValue = 1;

  void _incrementValue(quantity) {
    if (cartValue < quantity) {
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

  late User loggedUser;

  late List<ColorModel> colors;
  late ColorModel? selectedColor;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProduct(id: widget.productId));
    loggedUser = context.read<UserBloc>().state.user!;
    colors = context.read<ColorBloc>().state.colors!;
    selectedColor = null;
    // if (colors.isNotEmpty) {
    //   selectedColor = colors.first;
    // }

    // if (colors.isEmpty) {
    //   selectedColor = null;
    // }

    context.read<CartBloc>().add(LoadCart(
          userId: loggedUser.id,
          sellerId: widget.sellerId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        if (state is LoadedSeller) {
          Seller seller = state.seller;
          List<ColorModel> productColors = [];

          return Scaffold(
            backgroundColor: kBackgroundColor,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      WholesaleScreen.route(sellerId: seller.id),
                    );
                  },
                  icon: AvatarImage(
                    imageUrl: seller.imageUrl,
                    isSeller: true,
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<ProductBloc>()
                    .add(LoadProduct(id: widget.productId));
              },
              color: kPrimaryColor,
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is LoadedProduct) {
                    if (colors.isNotEmpty) {
                      setState(() {
                        productColors = state.product.colors;
                      });
                    }
                  }
                },
                builder: (context, state) {
                  if (state is LoadedProduct) {
                    Product product = state.product;

                    return ListView(
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            image: product.imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        "${AppUrls.SERVER_URL}/${product.imageUrl}"),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image:
                                        AssetImage("assets/images/product.jpg"),
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
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              product.description != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        product.description!,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              verticalSpace(height: 15),
                              Text(
                                formatPrice(product.price),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalSpace(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Product Color: ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      horizontalSpace(),
                                      selectedColor != null
                                          ? SizedBox(
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    HexColor.fromHex(
                                                  selectedColor!.hexCode,
                                                ),
                                                radius: 8,
                                              ),
                                            )
                                          : const Text(
                                              "Any Color",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                    ],
                                  ),
                                  BlocBuilder<ColorBloc, ColorState>(
                                    builder: (context, state) {
                                      if (state is LoadedColors) {
                                        return state.colors.isNotEmpty
                                            ? DropdownButton(
                                                underline:
                                                    const SizedBox.shrink(),
                                                focusColor: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                value: selectedColor ??
                                                    state.colors.first,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: colors
                                                    .map((ColorModel color) {
                                                  return DropdownMenuItem(
                                                    value: color,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      child: Text(
                                                        color.name,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (ColorModel? newValue) {
                                                  setState(() {
                                                    selectedColor = newValue!;
                                                  });

                                                  if (!productColors.contains(
                                                      selectedColor)) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Color not available for product"),
                                                      ),
                                                    );
                                                  }
                                                },
                                              )
                                            : const Text("No Colors");
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
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "${product.quantity} left in stock",
                                  style: const TextStyle(
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
                                    onPressed: () =>
                                        _incrementValue(product.quantity),
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
                                    child: BlocBuilder<CartBloc, CartState>(
                                      builder: (context, state) {
                                        if (state is LoadedCart) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              context.read<CartItemBloc>().add(
                                                    AddCartItem(
                                                      quantity: cartValue,
                                                      cartId: state.cart.id,
                                                      productId: product.id,
                                                    ),
                                                  );
                                            },
                                            child: const Text(
                                              "Add to Cart",
                                            ),
                                          );
                                        }

                                        if (state is CartStateCreated) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              context.read<CartItemBloc>().add(
                                                    AddCartItem(
                                                      quantity: cartValue,
                                                      cartId: state.cartId,
                                                      productId: product.id,
                                                    ),
                                                  );
                                            },
                                            child: const Text(
                                              "Add to Cart",
                                            ),
                                          );
                                        }

                                        return ElevatedButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                                  CreateCart(
                                                    userId: loggedUser.id,
                                                    sellerId: seller.id,
                                                  ),
                                                );
                                          },
                                          child: const Text(
                                            "Create Cart",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            floatingActionButton: BlocListener<CartItemBloc, CartItemState>(
              listener: (context, state) {
                if (state is CartItemStateChanged) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Item added to cart"),
                    ),
                  );
                  context.read<CartBloc>().add(LoadCart(
                        userId: loggedUser.id,
                        sellerId: seller.id,
                      ));
                }
              },
              child: BlocBuilder<CartBloc, CartState>(
                buildWhen: (previous, current) =>
                    current.props != previous.props,
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
                        ));
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
            ),
          );
        }

        return const ScreenViewLoading();
      },
    );
  }
}
