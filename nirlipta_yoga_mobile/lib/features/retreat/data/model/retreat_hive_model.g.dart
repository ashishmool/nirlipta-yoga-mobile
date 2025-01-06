// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retreat_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RetreatHiveModelAdapter extends TypeAdapter<RetreatHiveModel> {
  @override
  final int typeId = 2;

  @override
  RetreatHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RetreatHiveModel(
      retreatId: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
      pricePerPerson: fields[5] as double,
      maxParticipants: fields[6] as int?,
      address: fields[7] as String?,
      mapLocation: fields[8] as String?,
      mealsInfo: (fields[9] as List?)?.cast<String>(),
      organizer: fields[10] as String,
      guests: (fields[11] as List?)?.cast<GuestHiveModel>(),
      featuringEvents: (fields[12] as List?)?.cast<String>(),
      accommodationId: fields[13] as String?,
      instructorId: fields[14] as String?,
      photo: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RetreatHiveModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.retreatId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.pricePerPerson)
      ..writeByte(6)
      ..write(obj.maxParticipants)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.mapLocation)
      ..writeByte(9)
      ..write(obj.mealsInfo)
      ..writeByte(10)
      ..write(obj.organizer)
      ..writeByte(11)
      ..write(obj.guests)
      ..writeByte(12)
      ..write(obj.featuringEvents)
      ..writeByte(13)
      ..write(obj.accommodationId)
      ..writeByte(14)
      ..write(obj.instructorId)
      ..writeByte(15)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetreatHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GuestHiveModelAdapter extends TypeAdapter<GuestHiveModel> {
  @override
  final int typeId = 0;

  @override
  GuestHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GuestHiveModel(
      name: fields[0] as String?,
      guestPhoto: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GuestHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.guestPhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuestHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
