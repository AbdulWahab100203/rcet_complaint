import 'package:flutter/material.dart';
import '../screens/auth/welcome_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/signup_form_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/auth/forget_screen.dart';
import '../screens/dashboard/setting_screen.dart';
import '../screens/dashboard/complaint_box.dart';
import '../screens/dashboard/event.dart';
import '../screens/dashboard/main_dashboard_screen.dart';
import '../screens/dashboard/edit_profile.dart';

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
  static const String event = '/EventScheduleScreen';
  static const String mainDashboard = '/ComplaintScreenMain';
  static const String editProfile = '/edit-profile';

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
          builder: (_) => const DashboardScreen(),
        );
      case setting:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
        );
      case forget:
        return MaterialPageRoute(
          builder: (_) => const ForgetScreen(),
        );
      case complaintbox:
        return MaterialPageRoute(
          builder: (_) => const ComplaintScreen(),
        );
      case event:
        return MaterialPageRoute(
          builder: (_) => EventScheduleScreen(),
        );
      case mainDashboard:
        return MaterialPageRoute(
          builder: (_) => ComplaintScreenMain(),
        );
      case editProfile:
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(),
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
