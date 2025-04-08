import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(//prevent from overlapping
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/logo.png',
                height: 180,
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Get started',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'I have an account',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                backgroundColor: Colors.white,
                textColor: Colors.black,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
