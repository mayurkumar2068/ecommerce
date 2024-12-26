import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // Add this import

import 'Splash/splash.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));  // Wrap your app with ProviderScope
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
