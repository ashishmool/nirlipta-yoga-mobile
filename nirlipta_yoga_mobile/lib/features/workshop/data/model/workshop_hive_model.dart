import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/workshop_entity.dart';

part 'workshop_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to the model.

@HiveType(typeId: HiveTableConstant.workshopTableId)
class WorkshopHiveModel extends Equatable {
  @HiveField(0)
  final String? workshopId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? address;

  @HiveField(4)
  final String? classroomInfo;

  @HiveField(5)
  final String? mapLocation;

  @HiveField(6)
  final String difficultyLevel;

  @HiveField(7)
  final double price;

  @HiveField(8)
  final double? discountPrice;

  @HiveField(9)
  final String categoryId;

  @HiveField(10)
  final String? photo;

  @HiveField(11)
  final List<WorkshopModuleHiveModel> modules;

  WorkshopHiveModel({
    String? workshopId,
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
  }) : workshopId = workshopId ?? const Uuid().v4();

  // Initial Constructor
  const WorkshopHiveModel.initial()
      : workshopId = '',
        title = '',
        description = null,
        address = null,
        classroomInfo = null,
        mapLocation = null,
        difficultyLevel = 'beginner',
        price = 0.0,
        discountPrice = null,
        categoryId = '',
        photo = null,
        modules = const [];

  // Empty Constructor
  const WorkshopHiveModel.empty()
      : workshopId = '',
        title = '',
        description = null,
        address = null,
        classroomInfo = null,
        mapLocation = null,
        difficultyLevel = '',
        price = 0.0,
        discountPrice = null,
        categoryId = '',
        photo = null,
        modules = const [];

  // From Entity
  factory WorkshopHiveModel.fromEntity(WorkshopEntity entity) {
    return WorkshopHiveModel(
      workshopId: entity.id,
      title: entity.title,
      description: entity.description,
      address: entity.address,
      classroomInfo: entity.classroomInfo,
      mapLocation: entity.mapLocation,
      difficultyLevel: entity.difficultyLevel,
      price: entity.price,
      discountPrice: entity.discountPrice,
      categoryId: entity.categoryId,
      photo: entity.photo,
      modules: entity.modules
          .map((module) => WorkshopModuleHiveModel.fromEntity(module))
          .toList(),
    );
  }

  // To Entity
  WorkshopEntity toEntity() {
    return WorkshopEntity(
      id: workshopId,
      title: title,
      description: description,
      address: address,
      classroomInfo: classroomInfo,
      mapLocation: mapLocation,
      difficultyLevel: difficultyLevel,
      price: price,
      discountPrice: discountPrice,
      categoryId: categoryId,
      photo: photo,
      modules: modules.map((module) => module.toEntity()).toList(),
    );
  }

  // To Entity List
  static List<WorkshopHiveModel> fromEntityList(
      List<WorkshopEntity> entityList) {
    return entityList
        .map((entity) => WorkshopHiveModel.fromEntity(entity))
        .toList();
  }

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
        modules,
      ];
}

@HiveType(typeId: HiveTableConstant.workshopModuleTableId)
class WorkshopModuleHiveModel extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int duration;

  const WorkshopModuleHiveModel({
    required this.name,
    required this.duration,
  });

  // From Entity
  factory WorkshopModuleHiveModel.fromEntity(ModuleEntity entity) {
    return WorkshopModuleHiveModel(
      name: entity.name,
      duration: entity.duration,
    );
  }

  // To Entity
  ModuleEntity toEntity() {
    return ModuleEntity(
      name: name,
      duration: duration,
    );
  }

  @override
  List<Object?> get props => [name, duration];
}
