part of 'workshop_bloc.dart';

sealed class WorkshopEvent extends Equatable {
  const WorkshopEvent();

  @override
  List<Object?> get props => [];
}

final class LoadWorkshops extends WorkshopEvent {}

final class AddWorkshop extends WorkshopEvent {
  final String? workshopId;
  final String title;
  final String? description;
  final String? address;
  final String? classroomInfo;
  final String? mapLocation;
  final String difficultyLevel;
  final double price;
  final double? discountPrice;
  final String categoryId;
  final String? photo;
  final List<ModuleEntity> modules;

  const AddWorkshop(
      {this.workshopId,
      required this.title,
      this.description,
      this.address,
      this.classroomInfo,
      this.mapLocation,
      required this.difficultyLevel,
      required this.price,
      this.discountPrice,
      required this.categoryId,
      this.photo,
      required this.modules});

  @override
  List<Object?> get props => [
        workshopId,
        title,
        description,
        address,
        classroomInfo,
        mapLocation,
        difficultyLevel,
        price,
        discountPrice,
        categoryId,
        photo,
        modules
      ];
}

final class DeleteWorkshop extends WorkshopEvent {
  final String workshopId;

  const DeleteWorkshop({required this.workshopId});

  @override
  List<Object?> get props => [workshopId];
}
