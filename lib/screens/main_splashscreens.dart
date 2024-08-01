import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internship_test/fonts/font_satoshi.dart';
import 'package:internship_test/screens/chose_screens.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ChoseScreens()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hi, Welcome!',
          style: SatoshiTextStyle.normalStyle.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.07
          ),
        ),
      ),
    );
  }
}
