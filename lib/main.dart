import 'package:fitness/screens/colors.dart';
import 'package:fitness/screens/splashPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //use for remove banner of debug on appbar
      title: 'Flutter demo',
      theme: ThemeData(
        primaryColor: darkBlue,
        secondaryHeaderColor: darkBlue,
      ),
      home: const SplashScreen(),
    );
  }
}
