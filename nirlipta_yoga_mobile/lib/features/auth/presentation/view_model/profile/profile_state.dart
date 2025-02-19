part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isUpdateLoading;
  final bool isUpdateSuccess;
  final UserEntity? user;
  final String? errorMessage;

  ProfileState({
    required this.isLoading,
    required this.isSuccess,
    required this.isUpdateLoading,
    required this.isUpdateSuccess,
    this.user,
    this.errorMessage,
  });

  ProfileState.initial()
      : isLoading = false,
        isSuccess = false,
        isUpdateLoading = false,
        isUpdateSuccess = false,
        user = null,
        errorMessage = null;

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isUpdateLoading,
    bool? isUpdateSuccess,
    UserEntity? user,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isUpdateLoading,
        isUpdateSuccess,
        user,
        errorMessage,
      ];
}
