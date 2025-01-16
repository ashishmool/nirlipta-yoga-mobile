import 'package:equatable/equatable.dart';

class WorkshopEntity extends Equatable {
  final String? id;
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

  const WorkshopEntity({
    this.id,
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
    required this.modules,
  });

  @override
  List<Object?> get props => [
        id,
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
        modules,
      ];
}

class ModuleEntity extends Equatable {
  final String name;
  final int duration;

  const ModuleEntity({
    required this.name,
    required this.duration,
  });

  @override
  List<Object?> get props => [name, duration];
}
