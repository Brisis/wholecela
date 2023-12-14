import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/app_screens/contact_page.dart';
import 'package:wholecela/presentation/screens/app_screens/tcs_page.dart';
import 'package:wholecela/presentation/screens/auth/login_screen.dart';
import 'package:wholecela/presentation/screens/cart_combined_screen.dart';
import 'package:wholecela/presentation/screens/home_screen.dart';
import 'package:wholecela/presentation/screens/order_history_screen.dart';
import 'package:wholecela/presentation/screens/profile_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';

class MenuDrawer extends StatelessWidget {
  final User user;
  const MenuDrawer({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  ProfileScreen.route(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AvatarImage(
                    imageUrl: user.imageUrl,
                  ),
                  horizontalSpace(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 12,
                          color: kBlackFaded,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(height: 30),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  HomeScreen.route(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.compare_arrows_sharp),
                  horizontalSpace(),
                  const Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            verticalSpace(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  ProfileScreen.route(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person),
                  horizontalSpace(),
                  const Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            verticalSpace(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CartCombinedScreen.route(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_basket),
                  horizontalSpace(),
                  const Text(
                    "My Carts",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            verticalSpace(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  OrderHistoryScreen.route(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart),
                  horizontalSpace(),
                  const Text(
                    "Order History",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            verticalSpace(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  ContactScreen.route(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.call),
                  horizontalSpace(),
                  const Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            verticalSpace(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PrivacyTermsAndConditionsScreen.route(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.menu_book_rounded),
                  horizontalSpace(),
                  const Text(
                    "Privacy, T&Cs",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            verticalSpace(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        LoginScreen.route(),
                        ((Route<dynamic> route) => false),
                      );
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: kWarningColor,
                      ),
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
