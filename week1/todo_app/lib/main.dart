import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfriTask',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomeScreen(),
    );
  }
}
