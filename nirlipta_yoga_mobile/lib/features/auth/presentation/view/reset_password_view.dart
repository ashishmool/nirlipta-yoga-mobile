import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/logo.dart';
import '../view_model/reset_password/reset_password_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();

  final _gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Logo.colour(height: 80.0),
                    const SizedBox(height: 72),
                    const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFB8978C),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      key: const ValueKey('email'),
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('otp'),
                      controller: _otpController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'OTP',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the OTP';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('newPassword'),
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    _gap,
                    BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password reset successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context); // Navigate back after success
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
                        return ElevatedButton(
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
                              ? const CircularProgressIndicator()
                              : const Text('Reset Password'),
                        );
                      },
                    ),
                    const SizedBox(height: 32), // Space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          key: const ValueKey('backButton'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Go Back',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
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
      ),
    );
  }
}
