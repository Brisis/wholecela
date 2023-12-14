import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/cart_bloc/cart_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/data/models/cart.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/cart_screen.dart';
import 'package:wholecela/presentation/screens/profile_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/cart_combined_card.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';

class CartCombinedScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const CartCombinedScreen(),
    );
  }

  const CartCombinedScreen({super.key});

  @override
  State<CartCombinedScreen> createState() => _CartCombinedScreenState();
}

class _CartCombinedScreenState extends State<CartCombinedScreen> {
  late User loggedUser;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
  }

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
          "My Carts",
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
        onRefresh: () async {},
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) => current.carts != null,
            builder: (context, state) {
              if (state is LoadedCarts) {
                List<Cart> carts = state.carts;

                final double total =
                    carts.fold(0, (sum, item) => sum + item.total);

                return ListView(
                  children: [
                    Text(
                      "Total Carts : ${carts.length}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CartScreen.route(sellerId: carts[index].sellerId),
                            );
                          },
                          child: CartCombinedCard(
                            cart: carts[index],
                          ),
                        );
                      },
                    ),
                    verticalSpace(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          formatPrice(total),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
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
}
