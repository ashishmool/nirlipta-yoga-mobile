// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkshopHiveModelAdapter extends TypeAdapter<WorkshopHiveModel> {
  @override
  final int typeId = 1;

  @override
  WorkshopHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkshopHiveModel(
      workshopId: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String?,
      address: fields[3] as String?,
      classroomInfo: fields[4] as String?,
      mapLocation: fields[5] as String?,
      difficultyLevel: fields[6] as String,
      price: fields[7] as double,
      discountPrice: fields[8] as double?,
      categoryId: fields[9] as String,
      photo: fields[10] as String?,
      modules: (fields[11] as List).cast<WorkshopModuleHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkshopHiveModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.workshopId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.classroomInfo)
      ..writeByte(5)
      ..write(obj.mapLocation)
      ..writeByte(6)
      ..write(obj.difficultyLevel)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.discountPrice)
      ..writeByte(9)
      ..write(obj.categoryId)
      ..writeByte(10)
      ..write(obj.photo)
      ..writeByte(11)
      ..write(obj.modules);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkshopHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkshopModuleHiveModelAdapter
    extends TypeAdapter<WorkshopModuleHiveModel> {
  @override
  final int typeId = 2;

  @override
  WorkshopModuleHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkshopModuleHiveModel(
      name: fields[0] as String,
      duration: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorkshopModuleHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkshopModuleHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
