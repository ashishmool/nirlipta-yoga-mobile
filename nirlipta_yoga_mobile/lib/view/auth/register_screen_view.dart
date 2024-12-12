import 'package:flutter/material.dart';
import '../../common/logo.dart';

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  _RegisterScreenViewState createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  static const String adminEmail = "admin@email.com"; // Testing Purpose Only

  bool _hasNoMedicalConditions = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _medicalConditionController =
  TextEditingController();
  bool _isEmailValid = false;

  // Regex for email validation
  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _medicalConditionController.dispose();
    super.dispose();
  }

  // Email validation method
  void _validateEmail() {
    setState(() {
      _isEmailValid = _emailRegex.hasMatch(_emailController.text.trim());
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

                // Logo
                const Logo.colour(height: 80.0),
                const SizedBox(height: 72),
                // Welcome Text
                Center(
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: secondaryColor,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email Field
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(fontFamily: 'Gilroy'),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Email address',
                        hintStyle: const TextStyle(fontFamily: 'Gilroy'),
                        errorText: _emailController.text.isNotEmpty &&
                            !_isEmailValid
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

                    // Medical Condition Field
                    TextField(
                      controller: _medicalConditionController,
                      enabled: !_hasNoMedicalConditions,
                      style: const TextStyle(fontFamily: 'Gilroy'),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.local_hospital_outlined),
                        hintText: 'Medical conditions (separated by commas)',
                        hintStyle: const TextStyle(fontFamily: 'Gilroy'),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),

                    // Medical Condition Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _hasNoMedicalConditions,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _hasNoMedicalConditions = value ?? false;
                              if (_hasNoMedicalConditions) {
                                _medicalConditionController.clear();
                              }
                            });
                          },
                        ),
                        Text(
                          'I have no medical conditions',
                          style: TextStyle(
                            fontSize: 16,
                            color: secondaryColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Continue Button
                    ElevatedButton(
                      onPressed: _isEmailValid
                          ? () {
                        final email = _emailController.text.trim();
                        final medicalConditions =
                        _hasNoMedicalConditions
                            ? 'None'
                            : _medicalConditionController
                            .text
                            .trim();

                        if (email == adminEmail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Check Email for Verification!',
                                style: TextStyle(fontFamily: 'Gilroy'),
                              ),
                              backgroundColor: primaryColor,
                            ),
                          );
                          // Navigate to OTP Screen
                          Navigator.pushNamed(context, '/verify-otp');
                        } else {
                          // Handle other cases
                          debugPrint('Email: $email');
                          debugPrint('Medical Conditions: $medicalConditions');
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isEmailValid
                            ? primaryColor
                            : primaryColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Login Redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Log In',
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
          ),
        ),
      ),
    );
  }
}
