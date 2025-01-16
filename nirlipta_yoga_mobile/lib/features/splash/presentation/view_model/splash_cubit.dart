import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/di.dart';
import '../../../onboarding/presentation/view/onboarding_view.dart';
import '../../../onboarding/presentation/view_model/onboarding_cubit.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Ensure context is mounted before navigating
      if (context.mounted) {
        // Navigate to OnboardingView wrapped in BlocProvider
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              // Provide OnboardingCubit using getIt
              return BlocProvider<OnboardingCubit>(
                create: (_) => getIt<OnboardingCubit>(),
                // Ensure OnboardingCubit is available
                child: const OnboardingView(), // Navigate to OnboardingView
              );
            },
          ),
        );
      }
    });
  }
}
