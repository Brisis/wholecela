import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/auth/forgot_screen.dart';
import 'package:wholecela/presentation/screens/auth/register_screen.dart';
import 'package:wholecela/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    );
  }

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              "Welcome Back",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(),
            const Text(
              "Access your account on Wholecela",
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
            verticalSpace(height: 15),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                label: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            verticalSpace(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      ForgotScreen.route(),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(height: 30),
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
                      "Login",
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  RegisterScreen.route(),
                );
              },
              child: const Text(
                "Don't have an account? Register",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
