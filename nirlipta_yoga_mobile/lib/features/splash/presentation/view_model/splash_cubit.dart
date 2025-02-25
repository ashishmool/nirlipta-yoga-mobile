import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../home/presentation/view_model/home_cubit.dart';
import '../../../onboarding/presentation/view/onboarding_view.dart';
import '../../../onboarding/presentation/view_model/onboarding_cubit.dart';

class SplashCubit extends Cubit<void> {
  final HomeCubit _homeCubit;
  final OnboardingCubit _onboardingCubit;

  final TokenSharedPrefs _tokenSharedPrefs;

  SplashCubit(this._homeCubit, this._onboardingCubit, this._tokenSharedPrefs)
      : super(null);

  Future<void> checkTokenAndNavigate(BuildContext context) async {
    await Future.delayed(
        const Duration(seconds: 1)); // Optional delay for smooth transition

    final tokenResult = await _tokenSharedPrefs.getToken();

    tokenResult.fold(
      (failure) {
        // ❌ Log error & go to Login if token retrieval fails
        debugPrint("❌ Error fetching token: ${failure.message}");
        goToOnboarding(context);
      },
      (String? token) {
        if (token != null && token.trim().isNotEmpty) {
          // ✅ Token exists, go to HomePage
          debugPrint("✅ Token found: Navigating to Home");
          goToHome(context);
        } else {
          // ❌ No token, go to Login
          debugPrint("❌ No token found: Navigating to Onboarding");
          goToOnboarding(context);
        }
      },
    );
  }

  void goToHome(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: HomeView(),
          ),
        ),
      );
    }
  }

  Future<void> goToOnboarding(BuildContext context) async {
    // Add any delay if necessary
    await Future.delayed(const Duration(seconds: 1), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _onboardingCubit,
              child: OnboardingView(),
            ),
          ),
        );
      }
    });
  }

// Future<void> init(BuildContext context) async {
//   await Future.delayed(const Duration(seconds: 2), () async {
//     // Ensure context is mounted before navigating
//     if (context.mounted) {
//       // Navigate to OnboardingView wrapped in BlocProvider
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) {
//             // Provide OnboardingCubit using getIt
//             return BlocProvider<OnboardingCubit>(
//               create: (_) => getIt<OnboardingCubit>(),
//               // Ensure OnboardingCubit is available
//               child: const OnboardingView(), // Navigate to OnboardingView
//             );
//           },
//         ),
//       );
//     }
//   });
// }
}
