import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/retreat_entity.dart';

part 'retreat_hive_model.g.dart';

// Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to Model

@HiveType(typeId: HiveTableConstant.retreatTableId)
class RetreatHiveModel extends Equatable {
  @HiveField(0)
  final String? retreatId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime endDate;

  @HiveField(5)
  final double pricePerPerson;

  @HiveField(6)
  final int? maxParticipants;

  @HiveField(7)
  final String? address;

  @HiveField(8)
  final String? mapLocation;

  @HiveField(9)
  final List<String>? mealsInfo;

  @HiveField(10)
  final String organizer;

  @HiveField(11)
  final List<GuestHiveModel>? guests;

  @HiveField(12)
  final List<String>? featuringEvents;

  @HiveField(13)
  final String? accommodationId;

  @HiveField(14)
  final String? instructorId;

  @HiveField(15)
  final String? photo;

  RetreatHiveModel({
    String? retreatId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.pricePerPerson,
    this.maxParticipants,
    this.address,
    this.mapLocation,
    this.mealsInfo,
    required this.organizer,
    this.guests,
    this.featuringEvents,
    this.accommodationId,
    this.instructorId,
    this.photo,
  }) : retreatId = retreatId ?? const Uuid().v4();

  // Initial Constructor
  RetreatHiveModel.initial()
      : retreatId = '',
        title = '',
        description = '',
        startDate = DateTime.fromMillisecondsSinceEpoch(0),
        endDate = DateTime.fromMillisecondsSinceEpoch(0),
        pricePerPerson = 0.0,
        maxParticipants = 0,
        address = null,
        mapLocation = null,
        mealsInfo = null,
        organizer = '',
        guests = null,
        featuringEvents = null,
        accommodationId = null,
        instructorId = null,
        photo = null;

  // From Entity
  factory RetreatHiveModel.fromEntity(RetreatEntity entity) {
    return RetreatHiveModel(
      retreatId: entity.retreatId,
      title: entity.title,
      description: entity.description,
      startDate: entity.startDate,
      endDate: entity.endDate,
      pricePerPerson: entity.pricePerPerson,
      maxParticipants: entity.maxParticipants,
      address: entity.address,
      mapLocation: entity.mapLocation,
      mealsInfo: entity.mealsInfo,
      organizer: entity.organizer,
      guests: entity.guests?.map((e) => GuestHiveModel.fromEntity(e)).toList(),
      featuringEvents: entity.featuringEvents,
      accommodationId: entity.accommodationId,
      instructorId: entity.instructorId,
      photo: entity.photo,
    );
  }

  // To Entity
  RetreatEntity toEntity() {
    return RetreatEntity(
      retreatId: retreatId,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      pricePerPerson: pricePerPerson,
      maxParticipants: maxParticipants,
      address: address,
      mapLocation: mapLocation,
      mealsInfo: mealsInfo,
      organizer: organizer,
      guests: guests?.map((e) => e.toEntity()).toList(),
      featuringEvents: featuringEvents,
      accommodationId: accommodationId,
      instructorId: instructorId,
      photo: photo,
    );
  }

  // From Entity List
  static List<RetreatHiveModel> fromEntityList(List<RetreatEntity> entityList) {
    return entityList
        .map((entity) => RetreatHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        retreatId,
        title,
        description,
        startDate,
        endDate,
        pricePerPerson,
        maxParticipants,
        address,
        mapLocation,
        mealsInfo,
        organizer,
        guests,
        featuringEvents,
        accommodationId,
        instructorId,
        photo,
      ];
}

// Nested class for Guests
@HiveType(typeId: 0) // Nested objects don't need typeId
class GuestHiveModel extends Equatable {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? guestPhoto;

  const GuestHiveModel({this.name, this.guestPhoto});

  factory GuestHiveModel.fromEntity(GuestEntity entity) {
    return GuestHiveModel(
      name: entity.name,
      guestPhoto: entity.guestPhoto,
    );
  }

  GuestEntity toEntity() {
    return GuestEntity(
      name: name,
      guestPhoto: guestPhoto,
    );
  }

  @override
  List<Object?> get props => [name, guestPhoto];
}
