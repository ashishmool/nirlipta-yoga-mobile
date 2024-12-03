import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              // Lottie.asset(
              //   'assets/animations/loading.json',
              //   height: 200,
              //   repeat: true,
              // ),
              SvgPicture.asset(
                'assets/icons/nirlipta-logo.svg',
                height: 100,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
