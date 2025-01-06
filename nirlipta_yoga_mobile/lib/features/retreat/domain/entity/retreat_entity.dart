import 'package:equatable/equatable.dart';

class RetreatEntity extends Equatable {
  final String? retreatId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final double pricePerPerson;
  final int? maxParticipants;
  final String? address;
  final String? mapLocation;
  final List<String>? mealsInfo;
  final String organizer;
  final List<GuestEntity>? guests;
  final List<String>? featuringEvents;
  final String? accommodationId;
  final String? instructorId;
  final String? photo;

  const RetreatEntity({
    this.retreatId,
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
  });

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

class GuestEntity extends Equatable {
  final String? name;
  final String? guestPhoto;

  const GuestEntity({
    this.name,
    this.guestPhoto,
  });

  @override
  List<Object?> get props => [name, guestPhoto];
}
