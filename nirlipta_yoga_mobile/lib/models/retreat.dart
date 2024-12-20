// retreat.dart

class Guest {
  final String name;
  final String? photo;

  Guest({required this.name, this.photo});

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      name: json['name'],
      photo: json['photo'],
    );
  }
}

class Retreat {
  final String id;
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
  final List<Guest>? guests;
  final List<String>? featuringEvents;
  final String? accommodationId;
  final String? instructorId;
  final List<String>? photos;

  Retreat({
    required this.id,
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
    this.photos,
  });

  factory Retreat.fromJson(Map<String, dynamic> json) {
    return Retreat(
      id: json['retreat_id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      pricePerPerson: (json['price_per_person'] as num).toDouble(),
      maxParticipants: json['max_participants'],
      address: json['address'],
      mapLocation: json['map_location'],
      mealsInfo: List<String>.from(json['meals_info'] ?? []),
      organizer: json['organizer'],
      guests: (json['guests'] as List?)
          ?.map((guest) => Guest.fromJson(guest))
          .toList(),
      featuringEvents: List<String>.from(json['featuring_events'] ?? []),
      accommodationId: json['accommodation_id'],
      instructorId: json['instructor_id'],
      photos: List<String>.from(json['photos'] ?? []),
    );
  }
}
