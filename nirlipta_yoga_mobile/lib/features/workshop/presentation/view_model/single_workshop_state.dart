import 'package:equatable/equatable.dart';

abstract class SingleWorkshopState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SingleWorkshopInitial extends SingleWorkshopState {}

class SingleWorkshopLoading extends SingleWorkshopState {}

class SingleWorkshopLoaded extends SingleWorkshopState {
  final Map<String, dynamic> workshop;

  SingleWorkshopLoaded({required this.workshop});

  @override
  List<Object?> get props => [workshop];
}

class SingleWorkshopError extends SingleWorkshopState {
  final String message;

  SingleWorkshopError(this.message);

  @override
  List<Object?> get props => [message];
}
