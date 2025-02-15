part of 'account_bloc.dart';

class AccountState extends Equatable {
  final bool isLoading;
  final bool isImageLoading;
  final String? errorMessage;
  final String? imageName;
  final UserEntity? user;

  const AccountState({
    required this.isLoading,
    required this.isImageLoading,
    this.errorMessage,
    this.imageName,
    this.user,
  });

  AccountState.initial()
      : isLoading = false,
        isImageLoading = false,
        errorMessage = null,
        imageName = null,
        user = null;

  AccountState copyWith({
    bool? isLoading,
    bool? isImageLoading,
    String? errorMessage,
    String? imageName,
    UserEntity? user,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      imageName: imageName ?? this.imageName,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isImageLoading,
        errorMessage,
        imageName,
        user,
      ];
}
