import 'package:flutter/material.dart';
import 'package:atelier_4/pages/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traveling', 
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const 
        Color.fromARGB(255, 183, 58, 121)), 
        ), 
      home: Home(), 
    );
  }
}
