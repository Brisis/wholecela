import 'package:flutter/material.dart';
import 'package:wholecela/presentation/screens/app_screens/contact_page.dart';
import 'package:wholecela/presentation/screens/app_screens/tcs_page.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const ProfileScreen(),
    );
  }

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Initial Selected Value
  String dropdownvalue = 'Any';

  // List of items in our dropdown menu
  var items = [
    'Any',
    'Damofalls',
    'Chitungwiza',
    'Hatfield',
    'Warren Park',
    'Avondale',
  ];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                LoginScreen.route(),
                ((Route<dynamic> route) => false),
              );
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: kWarningColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const Text(
              "Account Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Benevolent Mudzinganyama",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    size: 16,
                  ),
                ),
              ],
            ),
            verticalSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/user.jpg",
                  ),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    size: 16,
                  ),
                ),
              ],
            ),
            verticalSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Location: ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButton(
                  underline: const SizedBox.shrink(),
                  focusColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          items,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
            verticalSpace(height: 15),
            const Text(
              "Login Security",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "********",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                horizontalSpace(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    size: 16,
                  ),
                ),
              ],
            ),
            // verticalSpace(
            //   height: 30,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         child: const Text(
            //           "Logout",
            //           style: TextStyle(color: kWarningColor),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            verticalSpace(
              height: 15,
            ),
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
            verticalSpace(),
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
            verticalSpace(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        ContactScreen.route(),
                      );
                    },
                    child: const Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 1.0,
                    color: kBlackFaded,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PrivacyTermsAndConditionsScreen.route(),
                      );
                    },
                    child: const Text(
                      "Privacy, T&Cs",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
