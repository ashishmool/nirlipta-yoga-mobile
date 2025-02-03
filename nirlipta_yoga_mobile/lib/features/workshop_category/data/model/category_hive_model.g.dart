// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryHiveModelAdapter extends TypeAdapter<CategoryHiveModel> {
  @override
  final int typeId = 3;

  @override
  CategoryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryHiveModel(
      categoryId: fields[0] as String?,
      name: fields[1] as String,
      description: fields[2] as String?,
      photo: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
