import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/view/login_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/register_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/splash_screen_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Gilroy',
      ),
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => const SplashScreenView(), // Splash View
        '/login': (context) => const LoginScreenView(), // Login View
        '/register': (context) => const RegisterScreenView(), // Register View
      },
    );
  }
}
