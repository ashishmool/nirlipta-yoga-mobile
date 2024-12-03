import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the login screen after a delay
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG Logo
              SvgPicture.asset(
                'assets/icons/logo-main.svg',
                height: 120,
                colorFilter: null, // Use original colors
              ),
              const SizedBox(height: 40),

              // Lottie Loading Animation
              Lottie.asset(
                'assets/animations/loading.json',
                height: 100,
                repeat: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
