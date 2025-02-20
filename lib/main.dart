import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
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
