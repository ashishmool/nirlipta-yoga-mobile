import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/onboarding_cubit.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Full screen image
            Expanded(
              child: Image.asset(
                'assets/images/onboarding-1.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            const SizedBox(height: 40),
            // Text with a button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Welcome to the App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger the OnboardingCubit to navigate to LoginView
                      context.read<OnboardingCubit>().goToLogin(context);
                    },
                    child: const Text('Go To Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
