import 'package:flutter/material.dart';
import 'package:yuvav1/pages/admin_page.dart';
import 'package:yuvav1/pages/flip_page.dart';
import 'pages/home_page.dart'; // ✅ import HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}