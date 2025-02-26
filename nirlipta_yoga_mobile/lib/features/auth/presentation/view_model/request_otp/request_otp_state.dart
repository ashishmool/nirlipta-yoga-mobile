part of 'request_otp_bloc.dart';

class RequestOtpState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const RequestOtpState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RequestOtpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RequestOtpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage, // Allow explicit null
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
