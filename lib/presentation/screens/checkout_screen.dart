import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/home_screen.dart';
import 'package:wholecela/presentation/screens/order_history_screen.dart';

class CheckoutScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const CheckoutScreen(),
    );
  }

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.greenAccent,
              size: 72,
            ),
            verticalSpace(height: 30),
            const Text(
              "Your order has been placed successfully.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        OrderHistoryScreen.route(),
                        ((Route<dynamic> route) => false),
                      );
                    },
                    child: const Text(
                      "Track Delivery",
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        HomeScreen.route(),
                        ((Route<dynamic> route) => false),
                      );
                    },
                    child: const Text(
                      "Continue shopping",
                    ),
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
