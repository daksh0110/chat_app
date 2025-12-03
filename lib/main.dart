import 'package:chat_app/widgets/primary_button.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2E4458)),
      ),
      home: Scaffold(
        body: Center(child: PrimaryButton(text: 'sample Text')),
      ),
    );
  }
}
