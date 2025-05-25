import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RCET App',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A1A4B),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A1A4B)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.welcome,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
