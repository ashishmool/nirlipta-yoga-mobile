// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryApiModel _$CategoryApiModelFromJson(Map<String, dynamic> json) =>
    CategoryApiModel(
      categoryId: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$CategoryApiModelToJson(CategoryApiModel instance) =>
    <String, dynamic>{
      '_id': instance.categoryId,
      'name': instance.name,
      'photo': instance.photo,
      'description': instance.description,
    };
