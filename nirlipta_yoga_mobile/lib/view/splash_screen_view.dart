import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the login screen after a delay
    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacementNamed(context, '/landing');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/loading.json',
                height: 200,
                repeat: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
