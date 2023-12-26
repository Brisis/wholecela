import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/cart_bloc/cart_bloc.dart';
import 'package:wholecela/business_logic/location_bloc/location_bloc.dart';
import 'package:wholecela/business_logic/seller/seller_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/data/models/location.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/cart_combined_screen.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/profile_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';
import 'package:wholecela/presentation/widgets/wholesale_card.dart';

class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  }

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User loggedUser;

  @override
  void initState() {
    super.initState();
    context.read<SellerBloc>().add(LoadSellers());
    context.read<LocationBloc>().add(LoadLocations());

    loggedUser = context.read<UserBloc>().state.user!;
    context.read<CartBloc>().add(LoadCarts(userId: loggedUser.id));
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
          "Wholecela",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                ProfileScreen.route(),
              );
            },
            icon: AvatarImage(
              imageUrl: loggedUser.imageUrl,
              isSeller: loggedUser.role == "seller",
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<LocationBloc>().add(LoadLocations());
          context.read<SellerBloc>().add(LoadSellers());
          context.read<CartBloc>().add(LoadCarts(userId: loggedUser.id));
        },
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
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
                  BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, state) {
                      if (state is LoadedLocations) {
                        List<Location> locations = state.locations;

                        Location? selectedLocation;
                        if (locations.isNotEmpty) {
                          selectedLocation = locations.first;
                        }
                        if (locations.isEmpty) {
                          selectedLocation = null;
                        }

                        return selectedLocation != null
                            ? DropdownButton(
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
                              )
                            : const Text("No locations");
                      }

                      return const Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              verticalSpace(
                height: 15,
              ),
              Expanded(
                child: BlocBuilder<SellerBloc, SellerState>(
                  buildWhen: (previous, current) {
                    return current.sellers != null;
                  },
                  builder: (context, state) {
                    if (state is LoadedSellers) {
                      List<Seller> sellers = state.sellers;
                      return ListView.builder(
                          itemCount: sellers.length,
                          itemBuilder: (context, index) {
                            return WholeSaleCard(
                              seller: sellers[index],
                            );
                          });
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current.carts != null,
        builder: (context, state) {
          if (state is LoadedCarts) {
            List<Cart> carts = state.carts;

            return FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                context.read<CartBloc>().add(LoadCarts(
                      userId: loggedUser.id,
                    ));
                Navigator.push(
                  context,
                  CartCombinedScreen.route(),
                );
              },
              tooltip: 'My Cart',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.shopping_basket),
                  horizontalSpace(width: 3),
                  Text(
                    carts.length.toString(),
                    style: const TextStyle(
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
                Icons.shopping_basket,
                color: kBlackFaded,
              ),
            );
          }

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
        },
      ),
    );
  }
}
