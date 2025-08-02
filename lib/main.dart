import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
//import 'pages/manage_cantique_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cantiques',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashPage(), //const ManageCantiquePage(),
    );
  }
}
