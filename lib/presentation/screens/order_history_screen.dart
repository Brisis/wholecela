import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/order_bloc/order_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/data/models/order.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/order_history_item_screen.dart';
import 'package:wholecela/presentation/screens/profile_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';

class OrderHistoryScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const OrderHistoryScreen(),
    );
  }

  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late User loggedUser;

  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    context.read<OrderBloc>().add(LoadOrders(userId: loggedUser.id));
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
          "Order History",
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
              isSeller: loggedUser.role == "seller",
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<OrderBloc>().add(LoadOrders(userId: loggedUser.id));
        },
        color: kPrimaryColor,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<OrderBloc, OrderState>(
              buildWhen: (previous, current) =>
                  previous != current && current is LoadedOrders,
              builder: (context, state) {
                if (state is LoadedOrders) {
                  final orders = state.orders;
                  if (orders.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          "Your order history is Empty",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Purchase History",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Download",
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 15),
                      Table(
                        border: TableBorder.all(color: kGreyColor),
                        children: [
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    "Invoice #",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    "Quantity",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    "Status",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ...List<TableRow>.generate(
                            orders.length,
                            (index) => TableRow(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      OrderHistoryItemScreen.route(
                                        orderId: orders[index].id,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Center(
                                      child: Text(
                                        orders[index]
                                            .id
                                            .substring(1, 10)
                                            .replaceAll(RegExp(r'[^\w\s]+'), '')
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                        "${orders[index].orderItems.length}"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      formatPrice(orders[index].totalPrice),
                                    ),
                                  ),
                                ),
                                orders[index].status == "PENDING"
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            OrderHistoryItemScreen.route(
                                              orderId: orders[index].id,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: const BoxDecoration(
                                              color: Colors.orangeAccent),
                                          child: const Center(
                                            child: Text("IN-PROGRESS"),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            OrderHistoryItemScreen.route(
                                              orderId: orders[index].id,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: const BoxDecoration(
                                              color: Colors.greenAccent),
                                          child: const Center(
                                            child: Text("DELIVERED"),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      ),
    );
  }
}
