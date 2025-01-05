import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/app/di/di.dart';

import '../core/theme/app_theme.dart';
import '../features/splash/presentation/view/splash_view.dart';
import '../features/splash/presentation/view_model/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nirlipta Yoga',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: SplashView(),
      ),
    );
  }
}
