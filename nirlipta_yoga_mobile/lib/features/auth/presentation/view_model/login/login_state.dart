part of 'login_bloc.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isPasswordVisible;

  LoginState({
    required this.isLoading,
    required this.isSuccess,
    required this.isPasswordVisible,
  });

  LoginState.initial()
      : isLoading = false,
        isSuccess = false,
        isPasswordVisible = false;

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
