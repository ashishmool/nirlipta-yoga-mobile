import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/workshop_entity.dart';
import '../repository/workshop_repository.dart';

class CreateWorkshopParams extends Equatable {
  final String title;
  final String difficultyLevel;
  final double price;
  final String categoryId;
  final String? description;
  final String? address;
  final String? classroomInfo;
  final String? mapLocation;
  final double? discountPrice;
  final String? photo;

  const CreateWorkshopParams({
    required this.title,
    required this.difficultyLevel,
    required this.price,
    required this.categoryId,
    this.description,
    this.address,
    this.classroomInfo,
    this.mapLocation,
    this.discountPrice,
    this.photo,
  });

  @override
  List<Object?> get props => [
        title,
        difficultyLevel,
        price,
        categoryId,
        description,
        address,
        classroomInfo,
        mapLocation,
        discountPrice,
        photo,
      ];
}

class CreateWorkshopUseCase
    implements UsecaseWithParams<void, CreateWorkshopParams> {
  final IWorkshopRepository workshopRepository;

  CreateWorkshopUseCase({required this.workshopRepository});

  @override
  Future<Either<Failure, void>> call(CreateWorkshopParams params) async {
    return await workshopRepository.createWorkshop(
      WorkshopEntity(
        title: params.title,
        difficultyLevel: params.difficultyLevel,
        price: params.price,
        categoryId: params.categoryId,
        description: params.description,
        address: params.address,
        classroomInfo: params.classroomInfo,
        mapLocation: params.mapLocation,
        discountPrice: params.discountPrice,
        photo: params.photo,
        modules: [], // Pass modules separately if needed
      ),
    );
  }
}
