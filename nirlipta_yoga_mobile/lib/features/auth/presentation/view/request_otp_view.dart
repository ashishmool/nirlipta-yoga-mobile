import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view/reset_password_view.dart';

import '../../../../app/di/di.dart';
import '../../../../core/common/logo.dart';
import '../view_model/request_otp/request_otp_bloc.dart';
import '../view_model/reset_password/reset_password_bloc.dart';

class RequestOtpView extends StatelessWidget {
  RequestOtpView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'a3.asis@gmail.com');

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
                      'Request OTP',
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
                          return 'Please enter a valid email address';
                        }
                        // Regex for validating email format
                        final emailRegex = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    _gap,
                    BlocConsumer<RequestOtpBloc, RequestOtpState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => getIt<ResetPasswordBloc>(),
                                child: ResetPasswordView(),
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('OTP sent to ${_emailController.text}'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (state.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage!),
                              // ✅ Now correctly shows API errors
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
                                    context.read<RequestOtpBloc>().add(
                                          RequestOtpSubmitted(email: email),
                                        );
                                  }
                                },
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Request OTP'),
                        );
                      },
                    ),

                    const SizedBox(height: 32), // Space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          key: const ValueKey('loginButton'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back to Login',
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
