import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  _RegisterScreenViewState createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  bool _hasNoMedicalConditions = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _medicalConditionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF9B6763); // Primary color
    final secondaryColor = const Color(0xFFB8978C); // Secondary color

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  // Logo
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/nirlipta-logo.svg',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Center(
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: secondaryColor,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Breadcrumbs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, size: 8, color: primaryColor),
                      const SizedBox(width: 4),
                      Icon(Icons.circle, size: 8, color: secondaryColor),
                      const SizedBox(width: 4),
                      Icon(Icons.circle, size: 8, color: secondaryColor),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: 'Email address',
                      hintStyle: const TextStyle(
                        fontFamily: 'Gilroy',
                      ),
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
                  const SizedBox(height: 20),

                  // Medical Condition Checkbox and TextField
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
                  TextField(
                    controller: _medicalConditionController,
                    enabled: !_hasNoMedicalConditions,
                    style: const TextStyle(
                      fontFamily: 'Gilroy',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.local_hospital_outlined),
                      hintText: 'Medical conditions (separated by commas)',
                      hintStyle: const TextStyle(
                        fontFamily: 'Gilroy',
                      ),
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
                  const SizedBox(height: 24),

                  // Continue Button
                  ElevatedButton(
                    onPressed: () {
                      // Perform registration logic
                      final email = _emailController.text;
                      final medicalConditions = _hasNoMedicalConditions
                          ? 'None'
                          : _medicalConditionController.text;

                      // Handle the registration data
                      debugPrint('Email: $email');
                      debugPrint('Medical Conditions: $medicalConditions');

                      // Example: Navigate to another screen
                      Navigator.pushNamed(context, '/welcome');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
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
                  const SizedBox(height: 16),

                  // Login Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: secondaryColor,
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
            ),
          ),
        ),
      ),
    );
  }
}
