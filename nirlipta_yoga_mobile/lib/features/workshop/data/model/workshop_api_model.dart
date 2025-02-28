import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/workshop_entity.dart';

part 'workshop_api_model.g.dart'; // Include the generated part file.

@JsonSerializable()
class WorkshopApiModel extends Equatable {
  @JsonKey(name: '_id')
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

  const WorkshopApiModel({
    this.workshopId,
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
  });

  const WorkshopApiModel.empty()
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
        photo = null;

  // From JSON
  // factory WorkshopApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$WorkshopApiModelFromJson(json);

  factory WorkshopApiModel.fromJson(Map<String, dynamic> json) {
    return WorkshopApiModel(
      workshopId: json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      difficultyLevel: json['difficulty_level'] as String? ?? '',
      categoryId: json['category'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      price: json['price'] != null ? json['price'].toDouble() : null,
      // Add this
      discountPrice: json['discount_price'] != null
          ? json['discount_price'].toDouble()
          : null, // Add this
    );
  }

  // To JSON
  Map<String, dynamic> toJson() => _$WorkshopApiModelToJson(this);

  // Convert API Object to Entity
  WorkshopEntity toEntity() => WorkshopEntity(
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
        modules: [],
      );

  // Convert Entity to API Object
  factory WorkshopApiModel.fromEntity(WorkshopEntity workshop) {
    return WorkshopApiModel(
      workshopId: workshop.id,
      title: workshop.title,
      description: workshop.description,
      address: workshop.address,
      classroomInfo: workshop.classroomInfo,
      mapLocation: workshop.mapLocation,
      difficultyLevel: workshop.difficultyLevel,
      price: workshop.price,
      discountPrice: workshop.discountPrice,
      categoryId: workshop.categoryId,
      photo: workshop.photo,
    );
  }

  // Convert API List to Entity List
  static List<WorkshopEntity> toEntityList(List<WorkshopApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
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
      ];
}
