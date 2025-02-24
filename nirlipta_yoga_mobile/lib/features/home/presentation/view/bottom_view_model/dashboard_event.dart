// import 'package:equatable/equatable.dart';
//
// abstract class DashboardEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// // Event to load initial data
// class LoadDashboardData extends DashboardEvent {}
//
// // Event to filter workshops by category
// class FilterWorkshops extends DashboardEvent {
//   final String category;
//   final List<String> selectedCategories;
//
//   FilterWorkshops(this.category, this.selectedCategories);
//
//   @override
//   List<Object?> get props => [category, selectedCategories];
// }

import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to load initial data
class LoadDashboardData extends DashboardEvent {}

// Event to filter workshops by multiple categories
class FilterWorkshops extends DashboardEvent {
  final List<String> selectedCategories;

  FilterWorkshops(this.selectedCategories);

  @override
  List<Object?> get props => [selectedCategories];
}

class SearchWorkshops extends DashboardEvent {
  final String query;

  SearchWorkshops(this.query);
}
