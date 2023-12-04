import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/location_bloc/location_bloc.dart';
import 'package:wholecela/business_logic/seller/seller_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
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

  late Location selectedLocation;
  late List<Location> locations;

  @override
  void initState() {
    super.initState();
    context.read<SellerBloc>().add(LoadSellers());
    loggedUser = context.read<UserBloc>().state.user!;
    locations = context.read<LocationBloc>().state.locations!;
    selectedLocation = locations.first;
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
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<LocationBloc>().add(LoadLocations());
          context.read<SellerBloc>().add(LoadSellers());
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                height: 15,
              ),
              Expanded(
                child: BlocBuilder<SellerBloc, SellerState>(
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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            CartCombinedScreen.route(),
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
