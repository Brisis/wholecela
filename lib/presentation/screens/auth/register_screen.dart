import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/auth_bloc/authentication_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/if_debugging.dart';
import 'package:wholecela/presentation/screens/app_screens/tcs_page.dart';
import 'package:wholecela/presentation/screens/auth/login_screen.dart';

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
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(
    text: "Ben${Random().nextInt(10)}".ifDebugging,
  );
  TextEditingController emailController = TextEditingController(
    text: "ben${Random().nextInt(10)}@gmail.com".ifDebugging,
  );
  TextEditingController passwordController = TextEditingController(
    text: "football".ifDebugging,
  );

  bool hasAcceptedTerms = true;

  // Initially password is obscure
  bool toggleValue = true;

  // Toggles the password show status
  void togglePassword() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  bool isValidEmail(email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  bool hasAuthErrors = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationStateError) {
              setState(() {
                hasAuthErrors = true;
                errorMessage = state.authError!.dialogText;
              });
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
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
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
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
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
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
                  TextFormField(
                    controller: passwordController,
                    obscureText: toggleValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be atleast 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: togglePassword,
                        icon: Icon(
                          toggleValue
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: toggleValue ? kPrimaryColor : kGreyColor,
                          size: 24,
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
                    title: Text(
                      "I have read and agreed with Wholecela's terms and conditions",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: hasAcceptedTerms ? kBlackColor : kWarningColor,
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
                  hasAuthErrors
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.deepPurple[50],
                            child: Center(
                              child: Text(
                                errorMessage,
                                style: const TextStyle(
                                  color: kWarningColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthenticationBloc,
                            AuthenticationState>(
                          builder: (context, state) {
                            if (state is AuthenticationStateLoading) {
                              return ElevatedButton(
                                onPressed: () {},
                                child: const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  hasAuthErrors = false;
                                });

                                if (!hasAcceptedTerms) {
                                  return;
                                }

                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthenticationBloc>().add(
                                        AuthenticationEventRegisterUser(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                }
                              },
                              child: const Text(
                                "Register",
                              ),
                            );
                          },
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
            );
          },
        ),
      ),
    );
  }
}
