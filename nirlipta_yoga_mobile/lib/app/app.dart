import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/app/di/di.dart';
import 'package:nirlipta_yoga_mobile/features/splash/presentation/view/splash_view.dart';
import 'package:nirlipta_yoga_mobile/features/splash/presentation/view_model/splash_cubit.dart';

import '../core/theme/app_theme.dart';
import '../core/theme/theme_cubit.dart';
import '../core/theme/theme_state.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Nirlipta Yoga',
            theme: AppTheme.getApplicationTheme(isDarkMode: state.isDarkMode),
            home: BlocProvider.value(
              value: getIt<SplashCubit>(),
              child: const SplashView(),
            ),
          );
        },
      ),
    );
  }
}
