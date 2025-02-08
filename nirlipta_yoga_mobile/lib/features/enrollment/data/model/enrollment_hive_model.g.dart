// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnrollmentHiveModelAdapter extends TypeAdapter<EnrollmentHiveModel> {
  @override
  final int typeId = 5;

  @override
  EnrollmentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnrollmentHiveModel(
      id: fields[0] as String?,
      userId: fields[1] as String,
      workshopId: fields[2] as String,
      paymentStatus: fields[3] as String,
      enrollmentDate: fields[4] as DateTime?,
      completionStatus: fields[5] as String,
      feedback: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EnrollmentHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.workshopId)
      ..writeByte(3)
      ..write(obj.paymentStatus)
      ..writeByte(4)
      ..write(obj.enrollmentDate)
      ..writeByte(5)
      ..write(obj.completionStatus)
      ..writeByte(6)
      ..write(obj.feedback);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnrollmentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
