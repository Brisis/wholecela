import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/order_bloc/order_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/profile_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';

class OrderHistoryItemScreen extends StatefulWidget {
  final String orderId;
  static Route route({required String orderId}) {
    return MaterialPageRoute(
      builder: (context) => OrderHistoryItemScreen(
        orderId: orderId,
      ),
    );
  }

  const OrderHistoryItemScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderHistoryItemScreen> createState() => _OrderHistoryItemScreenState();
}

class _OrderHistoryItemScreenState extends State<OrderHistoryItemScreen> {
  late User loggedUser;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    context.read<OrderBloc>().add(LoadOrder(id: widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
          context.read<OrderBloc>().add(LoadOrder(id: widget.orderId));
        },
        color: kPrimaryColor,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is LoadedOrder) {
                  final order = state.order;
                  final orderItems = order.orderItems;
                  if (orderItems.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          "Your order is Empty",
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
                            "Order Details",
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
                      verticalSpace(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Order: #${order.id.substring(1, 10).replaceAll(RegExp(r'[^\w\s]+'), '').toUpperCase()}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Status: ${order.status}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
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
                                    "Product Name",
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
                            orderItems.length,
                            (index) => TableRow(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                      vertical: 10,
                                    ),
                                    child: Center(
                                      child: Text(
                                        orderItems[index].product.title,
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child:
                                        Text("${orderItems[index].quantity}"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      formatPrice(orderItems[index].quantity *
                                          orderItems[index].product.price),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: orderItems[index].product.imageUrl !=
                                            null
                                        ? DecorationImage(
                                            //image: AssetImage(product.imageUrl!),
                                            image: NetworkImage(
                                                "${AppUrls.SERVER_URL}/thumbnails/${orderItems[index].product.imageUrl}"),
                                            fit: BoxFit.contain,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/product.jpg"),
                                            fit: BoxFit.contain,
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
