import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/core/theme/app_theme.dart';
import 'package:pinput/pinput.dart';

import '../../../../app/di/di.dart';
import '../../../../core/common/logo.dart';
import '../view_model/login/login_bloc.dart';
import '../view_model/reset_password/reset_password_bloc.dart';
import 'login_view.dart';

class ResetPasswordView extends StatefulWidget {
  final String email;

  const ResetPasswordView({Key? key, required this.email}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = primaryColor;
    final borderColor = secondaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Logo.colour(height: 80.0),
                const SizedBox(height: 48),
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFB8978C),
                  ),
                ),
                const SizedBox(height: 24),

                // Email Field
                TextFormField(
                  enabled: false,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),

                // OTP Field with Pinput
                Pinput(
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  closeKeyboardWhenCompleted: true,
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: borderColor),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Enter a valid (6-Digit) OTP sent in your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // New Password Field
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'New Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a new password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset successfully!'),
                          backgroundColor: primaryColor,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => getIt<LoginBloc>(),
                            child: LoginView(),
                          ),
                        ),
                        (Route<dynamic> route) =>
                            false, // Remove all previous routes
                      );
                    } else if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage!),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        onPressed: state.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text.trim();
                                  final otp = _otpController.text.trim();
                                  final newPassword =
                                      _newPasswordController.text.trim();

                                  context.read<ResetPasswordBloc>().add(
                                        ResetPasswordSubmitted(
                                          email: email,
                                          otp: otp,
                                          newPassword: newPassword,
                                        ),
                                      );
                                }
                              },
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Set New Password',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
