import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/auth_bloc/authentication_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/core/extensions/if_debugging.dart';
import 'package:wholecela/presentation/screens/auth/forgot_screen.dart';
import 'package:wholecela/presentation/screens/auth/register_screen.dart';

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
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(
    text: "ben${Random().nextInt(10)}@gmail.com".ifDebugging,
  );
  TextEditingController passwordController = TextEditingController(
    text: "football".ifDebugging,
  );

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

                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthenticationBloc>().add(
                                        AuthenticationEventLoginUser(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                }
                              },
                              child: const Text(
                                "Login",
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
            );
          },
        ),
      ),
    );
  }
}
