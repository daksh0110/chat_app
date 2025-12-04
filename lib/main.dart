import 'package:chat_app/screens/onboarding_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        fontFamily: 'SpaceGrotesk',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(5, 115, 243, 1),
        ),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFE2EDF5),
      ),
      home: Scaffold(body: RegisterScreen()),
    );
  }
}
