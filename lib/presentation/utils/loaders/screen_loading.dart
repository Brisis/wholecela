import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';

class ScreenViewLoading extends StatelessWidget {
  const ScreenViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
