import 'package:flutter/material.dart';
import '../screens/auth/welcome_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/signup_form_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/auth/forget_screen.dart';
import '../screens/dashboard/setting_screen.dart';
import '../screens/dashboard/complaint_box.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String newComplaint = '/new-complaint';
  static const String complaintDetails = '/complaint-details';
  static const String signUpForm = '/sign-up-form';
  static const String forget = '/forget';
  static const String setting = '/setting';
  static const String complaintbox = '/ComplaintScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
          ),
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case signUpForm:
        return MaterialPageRoute(
          builder: (_) => const SignUpFormScreen(),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => DashboardScreen(),
        );
      case setting:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
        );
      case forget:
        return MaterialPageRoute(
          builder: (_) => const ForgetScreen(),
        );
      case complaintbox:
        return MaterialPageRoute(
          builder: (_) => const ComplaintScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
