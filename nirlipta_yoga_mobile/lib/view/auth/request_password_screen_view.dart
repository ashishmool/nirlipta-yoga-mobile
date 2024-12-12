import 'package:flutter/material.dart';
import '../../common/logo.dart';
import '../../common/snackbar.dart';

class RequestPasswordScreenView extends StatefulWidget {
  const RequestPasswordScreenView({super.key});

  @override
  _RequestPasswordScreenViewState createState() =>
      _RequestPasswordScreenViewState();
}

class _RequestPasswordScreenViewState extends State<RequestPasswordScreenView> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = false; // Track if the email is valid
  String emailErrorMessage = ''; // Track the error message

  // Regex pattern for email validation
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Function to validate email
  void _validateEmail() {
    setState(() {
      if (emailRegex.hasMatch(emailController.text)) {
        isEmailValid = true;
        emailErrorMessage = ''; // Clear error if valid
      } else {
        isEmailValid = false;
        emailErrorMessage = 'Please enter registered email address';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF9B6763); // Primary color

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password Request"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  const Logo.colour(height: 80.0),
                  const SizedBox(height: 32),

                  // Header Text
                  Center(
                    child: Text(
                      'Request Password',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFB8978C),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  TextField(
                    controller: emailController,
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
                    onChanged: (value) {
                      _validateEmail();
                    },
                  ),
                  const SizedBox(height: 8),

                  // Email Error Message
                  if (emailErrorMessage.isNotEmpty)
                    Text(
                      emailErrorMessage,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton(
                    onPressed: isEmailValid
                        ? () {
                            showMySnackbar(context, 'Password Request Sent!');
                            // Navigate to Verification
                            Navigator.pushNamed(context, '/verify-otp');
                          }
                        : null, // Disable button if email is invalid
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Register Redirect
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
            ),
          ),
        ),
      ),
    );
  }
}
