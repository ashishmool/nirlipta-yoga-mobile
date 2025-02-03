import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? id;
  final String name;
  final String? description;
  final String? photo;

  const CategoryEntity({
    this.id,
    required this.name,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        photo,
      ];
}
