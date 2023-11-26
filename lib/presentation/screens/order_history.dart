import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/profile_screen.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';

class OrderHistoryScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const OrderHistoryScreen(),
    );
  }

  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: const MenuDrawer(),
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
            icon: const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/user.jpg",
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
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
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Quantity",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Invoice #",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ...List<TableRow>.generate(
                  5,
                  (index) => TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text("Product Name"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text("$index"),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text("892728"),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text("\$300"),
                      ),
                      index == 2
                          ? Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: const BoxDecoration(
                                  color: Colors.orangeAccent),
                              child: Text("INP - EXP: ${index}D"),
                            )
                          : Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: const BoxDecoration(
                                  color: Colors.greenAccent),
                              child: Text("DEL"),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}