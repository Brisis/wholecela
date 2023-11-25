import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/screens/app_screens/tcs_page.dart';
import 'package:wholecela/presentation/screens/auth/login_screen.dart';
import 'package:wholecela/presentation/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const RegisterScreen(),
    );
  }

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
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
              "Register",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(),
            const Text(
              "Create your account on Wholecela",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(height: 15),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                label: Text(
                  "Full Name",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
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
            CheckboxListTile(
              value: hasAcceptedTerms,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: kPrimaryColor,
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  hasAcceptedTerms = value!;
                });
              },
              title: const Text(
                "I have read and agreed with Wholecela's terms and conditions",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            verticalSpace(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PrivacyTermsAndConditionsScreen.route(),
                );
              },
              child: const Text(
                "Privacy, terms and conditions",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
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
                        HomeScreen.route(),
                        ((Route<dynamic> route) => false),
                      );
                    },
                    child: const Text(
                      "Register",
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
                  LoginScreen.route(),
                );
              },
              child: const Text(
                "Already have an account? Login",
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
