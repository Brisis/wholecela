import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/auth/reset_screen.dart';

class ForgotScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const ForgotScreen(),
    );
  }

  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
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
              "Forgot Password",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(),
            const Text(
              "Send reset link to email",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text(
                  "Email",
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
                      Navigator.push(
                        context,
                        ResetScreen.route(),
                      );
                    },
                    child: const Text(
                      "Proceed",
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
