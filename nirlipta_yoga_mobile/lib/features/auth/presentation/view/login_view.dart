import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view/register_view.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/home/presentation/view/home_view.dart';

import '../../../../app/di/di.dart';
import '../../../../core/common/logo.dart';
import '../../../../core/common/snackbar/snackbar.dart';
import '../../../home/presentation/view_model/home_cubit.dart';
import '../view_model/signup/register_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  final _gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 72),
                  const Logo.colour(height: 80.0), // Adding the Logo
                  const SizedBox(height: 72),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Center(
                        child: Text(
                          'Login',
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    key: const ValueKey('username'),
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  _gap,
                  TextFormField(
                    key: const ValueKey('password'),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_usernameController.text == 'kiran' &&
                            _passwordController.text == 'kiran123') {
                          debugPrint('Navigating to HomeView...');

                          // Trigger navigation to HomeView
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: getIt<HomeCubit>(),
                                child: HomeView(),
                              ),
                            ),
                          );
                        } else {
                          showMySnackBar(
                            context: context,
                            message: 'Invalid username or password',
                            color: Colors.red,
                          );
                        }
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/request-password');
                      },
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Color(0xFF9B6763)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don’t have an account?'),
                        TextButton(
                          key: const ValueKey('registerButton'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: context.read<RegisterBloc>(),
                                  child: RegisterView(),
                                ),
                              ),
                            );
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
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
