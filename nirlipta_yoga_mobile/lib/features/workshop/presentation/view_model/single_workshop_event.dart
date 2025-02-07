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
