import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/category_entity.dart';

part 'category_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to the model.

@HiveType(typeId: HiveTableConstant.categoryTableId)
class CategoryHiveModel extends Equatable {
  @HiveField(0)
  final String? categoryId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? photo;

  CategoryHiveModel({
    String? categoryId,
    required this.name,
    this.description,
    this.photo,
  }) : categoryId = categoryId ?? const Uuid().v4();

  // Initial Constructor
  const CategoryHiveModel.initial()
      : categoryId = '',
        name = '',
        description = null,
        photo = null;

  // From Entity
  factory CategoryHiveModel.fromEntity(CategoryEntity entity) {
    return CategoryHiveModel(
      categoryId: entity.id,
      name: entity.name,
      description: entity.description,
      photo: entity.photo,
    );
  }

  // To Entity
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: categoryId,
      name: name,
      description: description,
      photo: photo,
    );
  }

  // To Entity List
  static List<CategoryHiveModel> fromEntityList(
      List<CategoryEntity> entityList) {
    return entityList
        .map((entity) => CategoryHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        categoryId,
        name,
        description,
        photo,
      ];
}
