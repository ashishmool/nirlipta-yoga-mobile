import 'package:flutter/material.dart';
import '../../common/logo.dart';
import '../../common/snackbar.dart';


class RequestPasswordScreenView extends StatelessWidget {
  const RequestPasswordScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF9B6763); // Primary color
    final TextEditingController _emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password Request"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // Logo
                Logo(),
                const SizedBox(height: 32),

                // Header Text
                Center(
                  child: Text(
                    'Request Password',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFB8978C),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

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
                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    showMySnackbar(context, 'Password Request Sent!');
                    // Navigate to Verification
                    Navigator.pushNamed(context, '/verify-otp');
                  },
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
                      'Dont have an account?',
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
    );
  }
}