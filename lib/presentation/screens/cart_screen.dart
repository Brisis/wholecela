import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/location_bloc/location_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/location.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/checkout_screen.dart';
import 'package:wholecela/presentation/screens/wholesale_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/cart_card.dart';

class CartScreen extends StatefulWidget {
  final Seller seller;
  static Route route({required Seller seller}) {
    return MaterialPageRoute(
      builder: (context) => CartScreen(seller: seller),
    );
  }

  const CartScreen({
    super.key,
    required this.seller,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late User loggedUser;

  late Location selectedLocation;
  late List<Location> locations;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    locations = context.read<LocationBloc>().state.locations!;
    selectedLocation = locations.first;
  }

  @override
  Widget build(BuildContext context) {
    if (loggedUser.locationId != null) {
      setState(() {
        selectedLocation = locations
            .firstWhere((location) => location.id == loggedUser.locationId);
      });
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Cart - Metropeach Brownee",
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
        onRefresh: () async {},
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
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
                    child: const CartCard(),
                  );
                },
              ),
              verticalSpace(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Items : 3",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(height: 15),
                  const Text(
                    "\$48.00",
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
                        "Drop Location: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) {
                          if (state is LoadedLocations) {
                            return DropdownButton(
                              underline: const SizedBox.shrink(),
                              focusColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              value: selectedLocation,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: locations.map((Location location) {
                                return DropdownMenuItem(
                                  value: location,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(
                                      location.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Location? newValue) {
                                setState(() {
                                  selectedLocation = newValue!;
                                });
                              },
                            );
                          }

                          return const Text("No locations");
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
}
