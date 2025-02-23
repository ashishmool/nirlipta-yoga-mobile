import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/home/presentation/view/home_view.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../auth/presentation/view_model/login/login_bloc.dart';
import '../../../home/presentation/view_model/home_cubit.dart';

class OnboardingCubit extends Cubit<void> {
  final LoginBloc _loginBloc;
  final HomeCubit _homeCubit;

  final TokenSharedPrefs _tokenSharedPrefs;

  OnboardingCubit(this._loginBloc, this._tokenSharedPrefs, this._homeCubit)
      : super(null);

  Future<void> checkTokenAndNavigate(BuildContext context) async {
    await Future.delayed(
        const Duration(seconds: 1)); // Optional delay for smooth transition

    final tokenResult = await _tokenSharedPrefs.getToken();

    tokenResult.fold(
      (failure) {
        // ❌ Log error & go to Login if token retrieval fails
        debugPrint("❌ Error fetching token: ${failure.message}");
        goToLogin(context);
      },
      (String? token) {
        if (token != null && token.trim().isNotEmpty) {
          // ✅ Token exists, go to HomePage
          debugPrint("✅ Token found: Navigating to Home");
          goToHome(context);
        } else {
          // ❌ No token, go to Login
          debugPrint("❌ No token found: Navigating to Login");
          goToLogin(context);
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

  Future<void> goToLogin(BuildContext context) async {
    // Add any delay if necessary
    await Future.delayed(const Duration(seconds: 1), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _loginBloc,
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}
