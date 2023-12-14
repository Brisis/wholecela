import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/cart_bloc/cart_bloc.dart';
import 'package:wholecela/business_logic/cart_item_bloc/cart_item_bloc.dart';
import 'package:wholecela/business_logic/location_bloc/location_bloc.dart';
import 'package:wholecela/business_logic/seller/seller_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/data/models/cart_item.dart';
import 'package:wholecela/data/models/location.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/checkout_screen.dart';
import 'package:wholecela/presentation/screens/wholesale_screen.dart';
import 'package:wholecela/presentation/utils/loaders/screen_loading.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/cart_card.dart';

class CartScreen extends StatefulWidget {
  final String sellerId;
  static Route route({required String sellerId}) {
    return MaterialPageRoute(
      builder: (context) => CartScreen(sellerId: sellerId),
    );
  }

  const CartScreen({
    super.key,
    required this.sellerId,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late User loggedUser;

  late Location? selectedLocation;
  late List<Location> locations;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    locations = context.read<LocationBloc>().state.locations!;
    if (locations.isNotEmpty) {
      selectedLocation = locations.first;
    }
    if (locations.isEmpty) {
      selectedLocation = null;
    }

    context.read<SellerBloc>().add(LoadSeller(id: widget.sellerId));
    context
        .read<CartBloc>()
        .add(LoadCart(userId: loggedUser.id, sellerId: widget.sellerId));
  }

  @override
  Widget build(BuildContext context) {
    if (loggedUser.locationId != null) {
      setState(() {
        selectedLocation = locations
            .firstWhere((location) => location.id == loggedUser.locationId);
      });
    }

    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        if (state is LoadedSeller) {
          Seller seller = state.seller;
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
              onRefresh: () async {},
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is LoadedCart) {
                      Cart cart = state.cart;
                      context
                          .read<CartItemBloc>()
                          .add(LoadCartItems(cartId: cart.id));

                      List<CartItemModel> cartItems = cart.cartItems;
                      return ListView(
                        children: [
                          Text(
                            "Total Items : ${cartItems.length}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          verticalSpace(height: 15),
                          BlocBuilder<CartItemBloc, CartItemState>(
                            builder: (context, state) {
                              if (state is LoadedCartItems) {
                                List<CartItem> cartItems = state.cartItems;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cartItems.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   ProductScreen.route(
                                        //     seller: widget.seller,
                                        //     productId: productId,
                                        //   ),
                                        // );
                                      },
                                      child: CartCard(
                                        cartItem: cartItems[index],
                                      ),
                                    );
                                  },
                                );
                              }

                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            },
                          ),
                          verticalSpace(height: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Total Cost: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    formatPrice(cart.total),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Drop Location: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  BlocBuilder<LocationBloc, LocationState>(
                                    builder: (context, state) {
                                      if (state is LoadedLocations) {
                                        return selectedLocation != null
                                            ? DropdownButton(
                                                underline:
                                                    const SizedBox.shrink(),
                                                focusColor: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                value: selectedLocation,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: locations
                                                    .map((Location location) {
                                                  return DropdownMenuItem(
                                                    value: location,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      child: Text(
                                                        location.name,
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
                                                    (Location? newValue) {
                                                  setState(() {
                                                    selectedLocation =
                                                        newValue!;
                                                  });
                                                },
                                              )
                                            : const Text("No locations");
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
                                height: 30,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "Note: 3% delivery charge",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              verticalSpace(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CheckoutScreen.route(),
                                        );
                                      },
                                      child: const Text(
                                        "Make Payment",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {},
              tooltip: 'Empty Cart',
              child: const Icon(
                Icons.delete,
                color: kWarningColor,
                size: kIconLargeSize,
              ),
            ),
          );
        }

        return const ScreenViewLoading();
      },
    );
  }
}
