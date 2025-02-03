import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/category_entity.dart';

part 'category_api_model.g.dart'; // Include the generated part file.

@JsonSerializable()
class CategoryApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? categoryId;
  final String name;
  final String? photo;
  final String? description;

  const CategoryApiModel({
    this.categoryId,
    required this.name,
    this.description,
    this.photo,
  });

  const CategoryApiModel.empty()
      : categoryId = '',
        name = '',
        description = '',
        photo = null;

  // From JSON
  factory CategoryApiModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$CategoryApiModelToJson(this);

  // Convert API Object to Entity
  CategoryEntity toEntity() => CategoryEntity(
        id: categoryId,
        name: name,
        description: description,
        photo: photo,
      );

  // Convert Entity to API Object
  factory CategoryApiModel.fromEntity(CategoryEntity category) {
    return CategoryApiModel(
      categoryId: category.id,
      name: category.name,
      description: category.description,
      photo: category.photo,
    );
  }

  // Convert API List to Entity List
  static List<CategoryEntity> toEntityList(List<CategoryApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        categoryId,
        name,
        description,
        photo,
      ];
}
