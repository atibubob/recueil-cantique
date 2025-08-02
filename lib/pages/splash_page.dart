import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 51, 135, 247),
            const Color.fromARGB(255, 3, 51, 86),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important pour voir le dégradé
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // empêche la colonne de prendre tout l'espace vertical
            children: [
              Container(
                child: Icon(
                  Icons.book,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              Text(
                'REQUEIL DES CANTIQUES',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'casual'),
              ),
              SizedBox(height: 20), // Espace entre les deux textes
              Text('LILOBA NA NZAMBE AMEN!!!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
