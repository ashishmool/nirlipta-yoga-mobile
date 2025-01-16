part of 'workshop_bloc.dart';

sealed class WorkshopEvent extends Equatable {
  const WorkshopEvent();

  @override
  List<Object?> get props => [];
}

final class LoadWorkshops extends WorkshopEvent {}

final class AddWorkshop extends WorkshopEvent {
  final String title;
  final double price;
  final String difficultyLevel;
  final String categoryId;

  const AddWorkshop(
      {required this.title,
      required this.price,
      required this.difficultyLevel,
      required this.categoryId});

  @override
  List<Object?> get props => [title, price, difficultyLevel, categoryId];
}

final class DeleteWorkshop extends WorkshopEvent {
  final String workshopId;

  const DeleteWorkshop({required this.workshopId});

  @override
  List<Object?> get props => [workshopId];
}
