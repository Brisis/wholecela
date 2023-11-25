import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/auth/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    );
  }

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Wholecela",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(height: 30),
            SizedBox(
              height: 350,
              child: Image.asset(
                "assets/icons/icon.png",
                width: 200,
                height: 200,
              ),
            ),
            verticalSpace(height: 15),
            const Text(
              "Buy products at wholesale prices direct from your favourite verified Wholesalers accross the country.",
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
                      Navigator.push(
                        context,
                        RegisterScreen.route(),
                      );
                    },
                    child: const Text(
                      "Get Started",
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
