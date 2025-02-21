part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isUpdateLoading;
  final bool isUpdateSuccess;
  final bool isImageLoading;
  final bool isImageSuccess;
  final UserEntity? user;
  final String? imageName;
  final String? errorMessage;

  ProfileState({
    required this.isLoading,
    required this.isSuccess,
    required this.isUpdateLoading,
    required this.isUpdateSuccess,
    required this.isImageLoading,
    required this.isImageSuccess,
    this.user,
    this.imageName,
    this.errorMessage,
  });

  ProfileState.initial()
      : isLoading = false,
        isSuccess = false,
        isUpdateLoading = false,
        isUpdateSuccess = false,
        isImageLoading = false,
        isImageSuccess = false,
        user = null,
        imageName = null,
        errorMessage = null;

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isUpdateLoading,
    bool? isUpdateSuccess,
    bool? isImageLoading,
    bool? isImageSuccess,
    UserEntity? user,
    String? errorMessage,
    String? imageName,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      user: user ?? this.user,
      imageName: imageName ?? this.imageName,
      errorMessage: errorMessage ?? this.errorMessage,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      isImageSuccess: isImageSuccess ?? this.isImageSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isUpdateLoading,
        isUpdateSuccess,
        user,
        imageName,
        errorMessage,
      ];
}
