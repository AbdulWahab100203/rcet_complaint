import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                text: 'Login',
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
