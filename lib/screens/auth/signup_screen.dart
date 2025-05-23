import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/social_login_button.dart';
import '../../widgets/primary_button.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
              const SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(bottom: 90),
              ),
              // Social Login Buttons
              const SizedBox(height: 10),
              SocialLoginButton(
                icon: Icons.apple,
                onPressed: () {},
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                icon: Icons.email,
                onPressed: () {},
                backgroundColor: Colors.white,
                textColor: Colors.black,
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                icon: Icons.facebook,
                onPressed: () {},
                backgroundColor: const Color(0xFF1877F2),
                textColor: Colors.white,
              ),

              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 15),
              PrimaryButton(
                text: 'Sign up with E-mail',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.signUpForm);
                },
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
