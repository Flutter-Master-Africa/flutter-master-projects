import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/home_screen.dart';

final scheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF3B6EA5),
  brightness: Brightness.light,
).copyWith(surfaceContainerLow: const Color(0xFFF1F3F9));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets Cookbook',
      theme: ThemeData(useMaterial3: true),
      routes: appRoutes,
      home: const HomeScreen(),
    );
  }
}
