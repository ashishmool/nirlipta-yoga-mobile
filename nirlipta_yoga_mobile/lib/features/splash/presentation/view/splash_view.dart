import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkTokenAndNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Center the main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/loading.json',
                    height: screenHeight * 0.5, // Occupy 50% of screen height
                    repeat: true,
                  ),
                  const SizedBox(height: 30),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  const Text('Version: 1.0.0'),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // Positioned footer at the bottom
            Positioned(
              bottom: 10,
              left: screenWidth / 4,
              child: const Text(
                'Developed by: Ashish Mool (220417)',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
