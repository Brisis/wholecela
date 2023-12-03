import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';

class AppLoaderScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (context) => const AppLoaderScreen());
  }

  const AppLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset("assets/icons/icon.png"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
