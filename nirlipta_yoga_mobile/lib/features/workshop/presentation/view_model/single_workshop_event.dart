import 'package:equatable/equatable.dart';

abstract class SingleWorkshopEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSingleWorkshop extends SingleWorkshopEvent {
  final String workshopId;

  LoadSingleWorkshop(this.workshopId);

  @override
  List<Object?> get props => [workshopId];
}

class EnrollInWorkshop extends SingleWorkshopEvent {
  final String userId;
  final String workshopId;

  EnrollInWorkshop({required this.userId, required this.workshopId});

  @override
  List<Object?> get props => [userId, workshopId];
}
