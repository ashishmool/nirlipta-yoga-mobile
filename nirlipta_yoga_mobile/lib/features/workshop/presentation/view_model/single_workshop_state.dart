import 'package:equatable/equatable.dart';

abstract class SingleWorkshopState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SingleWorkshopInitial extends SingleWorkshopState {}

class SingleWorkshopLoading extends SingleWorkshopState {}

class SingleWorkshopLoaded extends SingleWorkshopState {
  final Map<String, dynamic> workshop;
  final bool isEnrolled;

  SingleWorkshopLoaded({required this.workshop, required this.isEnrolled});

  @override
  List<Object?> get props => [workshop, isEnrolled];
}

class SingleWorkshopError extends SingleWorkshopState {
  final String message;

  SingleWorkshopError(this.message);

  @override
  List<Object?> get props => [message];
}

class EnrollmentLoading extends SingleWorkshopState {}

class EnrollmentSuccess extends SingleWorkshopState {
  final String message;

  EnrollmentSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class EnrollmentError extends SingleWorkshopState {
  final String message;

  EnrollmentError(this.message);

  @override
  List<Object?> get props => [message];
}
