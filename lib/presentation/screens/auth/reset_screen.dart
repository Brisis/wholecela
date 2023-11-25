import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/auth/login_screen.dart';

class ResetScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const ResetScreen(),
    );
  }

  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hasAcceptedTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                "assets/icons/icon.png",
                width: 50,
                height: 50,
              ),
            ),
            verticalSpace(height: 15),
            const Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(),
            const Text(
              "Change your account password",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(height: 15),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                label: Text(
                  "New Password",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
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
                      "Reset",
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
