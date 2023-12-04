import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/color_bloc/color_bloc.dart';
import 'package:wholecela/business_logic/product/product_bloc.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/core/extensions/to_hex_color.dart';
import 'package:wholecela/data/models/color.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/screens/wholesale_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';

class ProductScreen extends StatefulWidget {
  final Seller seller;
  final String productId;
  static Route route({required Seller seller, required String productId}) {
    return MaterialPageRoute(
      builder: (context) => ProductScreen(
        seller: seller,
        productId: productId,
      ),
    );
  }

  const ProductScreen({
    super.key,
    required this.seller,
    required this.productId,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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

  late List<ColorModel> colors;
  late ColorModel selectedColor;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProduct(id: widget.productId));
    colors = context.read<ColorBloc>().state.colors!;
    if (colors.isNotEmpty) {
      selectedColor = colors.firstWhere((color) => color.name == "Any");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ColorModel> productColors = [];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.seller.name,
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
                WholesaleScreen.route(seller: widget.seller),
              );
            },
            icon: AvatarImage(
              imageUrl: widget.seller.imageUrl,
              isSeller: true,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(LoadProduct(id: widget.productId));
        },
        color: kPrimaryColor,
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is LoadedProduct) {
              setState(() {
                productColors = state.product.colors;
              });
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
                                  "${AppUrls.SERVER_URL}/uploads/thumbnails/${product.imageUrl}"),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage("assets/images/product.jpg"),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Product Color: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                horizontalSpace(),
                                selectedColor.name == "Any"
                                    ? const Text(
                                        "Any Color",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: HexColor.fromHex(
                                            selectedColor.hexCode),
                                        radius: 8,
                                      ),
                              ],
                            ),
                            BlocBuilder<ColorBloc, ColorState>(
                              builder: (context, state) {
                                if (state is LoadedColors) {
                                  return DropdownButton(
                                    underline: const SizedBox.shrink(),
                                    focusColor: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    value: selectedColor,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: colors.map((ColorModel color) {
                                      return DropdownMenuItem(
                                        value: color,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            color.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (ColorModel? newValue) {
                                      setState(() {
                                        selectedColor = newValue!;
                                      });

                                      if (!productColors
                                          .contains(selectedColor)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Color not available for product"),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }

                                return const Text("No Colors");
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
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            CartScreen.route(seller: widget.seller),
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
