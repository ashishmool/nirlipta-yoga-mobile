// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkshopApiModel _$WorkshopApiModelFromJson(Map<String, dynamic> json) =>
    WorkshopApiModel(
      workshopId: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      address: json['address'] as String?,
      classroomInfo: json['classroomInfo'] as String?,
      mapLocation: json['mapLocation'] as String?,
      difficultyLevel: json['difficultyLevel'] as String,
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      categoryId: json['categoryId'] as String,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$WorkshopApiModelToJson(WorkshopApiModel instance) =>
    <String, dynamic>{
      '_id': instance.workshopId,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'classroomInfo': instance.classroomInfo,
      'mapLocation': instance.mapLocation,
      'difficultyLevel': instance.difficultyLevel,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'categoryId': instance.categoryId,
      'photo': instance.photo,
    };
