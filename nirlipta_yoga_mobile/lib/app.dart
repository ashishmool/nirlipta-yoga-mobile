import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/view/app_landing_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/auth/request_password_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/auth/verify_otp_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/dashboard/student_dashboard_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/auth/login_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/auth/register_screen_view.dart';
import 'package:nirlipta_yoga_mobile/view/auth/reset_password_screen_view.dart';
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
        '/landing': (context) => const AppLandingScreenView(), // Splash View
        '/login': (context) => const LoginScreenView(), // Login View
        '/register': (context) => const RegisterScreenView(), // Register View
        '/request-password': (context) => const RequestPasswordScreenView(), // Request Password
        '/verify-otp': (context) => const VerifyOtpScreenView(), // Verify OTP
        '/reset-password': (context) => const ResetPasswordScreenView(), // Reset Password
        '/student-dashboard': (context) => const StudentDashboardScreenView(), // Student Dashboard
      },
    );
  }
}
