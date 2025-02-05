import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to load initial data
class LoadDashboardData extends DashboardEvent {}

// Event to filter workshops by category
class FilterWorkshops extends DashboardEvent {
  final String category;

  FilterWorkshops(this.category);

  @override
  List<Object?> get props => [category];
}
