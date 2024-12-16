import 'package:flutter/material.dart';
import '../../common/logo.dart';
import '../../common/snackbar.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  static const String validEmail = "admin@email.com";
  static const String validPassword = "admin";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  // Regex for email validation
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _validateInputs() {
    setState(() {
      // Validate email and password
      isEmailValid = emailRegex.hasMatch(emailController.text.trim());
      isPasswordValid = passwordController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF9B6763); // Primary color
    final secondaryColor = const Color(0xFFB8978C); // Secondary color

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white10,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 72), // Space after welcome text

                // Logo and Welcome Text
                const Logo.colour(height: 80.0),
                const SizedBox(height: 72),
                Center(
                  child: Text(
                    'Welcome!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFB8978C),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email Field
                    TextField(
                      controller: emailController,
                      style: const TextStyle(fontFamily: 'Gilroy'),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Email address',
                        hintStyle: const TextStyle(fontFamily: 'Gilroy'),
                        errorText: emailController.text.isNotEmpty &&
                            !isEmailValid
                            ? 'Please enter a valid email address'
                            : null,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Fixed space below email field

                    // Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      style: const TextStyle(fontFamily: 'Gilroy'),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: togglePasswordVisibility,
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontFamily: 'Gilroy'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Login Button
                    ElevatedButton(
                      onPressed: isEmailValid && isPasswordValid
                          ? () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        if (email == validEmail &&
                            password == validPassword) {
                          showMySnackbar(
                              context, 'Logged In Successfully');
                          Navigator.pushNamed(
                              context, '/student-dashboard');
                        } else {
                          showMySnackbar(context, 'Invalid Credentials');
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEmailValid && isPasswordValid
                            ? primaryColor
                            : primaryColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Forgot Password and Register
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/request-password');
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              fontSize: 16,
                              color: secondaryColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
