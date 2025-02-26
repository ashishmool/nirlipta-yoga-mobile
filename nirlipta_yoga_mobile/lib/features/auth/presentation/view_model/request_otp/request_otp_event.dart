part of 'request_otp_bloc.dart';

abstract class RequestOtpEvent extends Equatable {
  const RequestOtpEvent();

  @override
  List<Object> get props => [];
}

class RequestOtpSubmitted extends RequestOtpEvent {
  final String email;

  const RequestOtpSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}
