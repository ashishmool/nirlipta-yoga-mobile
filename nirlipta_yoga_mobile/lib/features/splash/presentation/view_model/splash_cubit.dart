import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../onboarding/presentation/view/onboarding_screen_view.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Open Onboarding Screen
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreenView(),
          ),
        );
      }
    });
  }
}
