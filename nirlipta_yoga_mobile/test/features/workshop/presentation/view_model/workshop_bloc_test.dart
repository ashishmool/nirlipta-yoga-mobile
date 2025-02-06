import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/core/error/failure.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/domain/entity/workshop_entity.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/domain/use_case/create_workshop_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/domain/use_case/delete_workshop_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/domain/use_case/get_all_workshops_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/workshop/presentation/view_model/workshop_bloc.dart';

// Fallback class for NoParams
class NoParams {}

class MockCreateWorkshopUseCase extends Mock implements CreateWorkshopUseCase {}

class MockGetAllWorkshopsUseCase extends Mock
    implements GetAllWorkshopsUseCase {}

class MockDeleteWorkshopUseCase extends Mock implements DeleteWorkshopUseCase {}

void main() {
  late WorkshopBloc workshopBloc;
  late MockCreateWorkshopUseCase createWorkshopUseCase;
  late MockGetAllWorkshopsUseCase getAllWorkshopsUseCase;
  late MockDeleteWorkshopUseCase deleteWorkshopUseCase;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    createWorkshopUseCase = MockCreateWorkshopUseCase();
    getAllWorkshopsUseCase = MockGetAllWorkshopsUseCase();
    deleteWorkshopUseCase = MockDeleteWorkshopUseCase();

    workshopBloc = WorkshopBloc(
      createWorkshopUseCase: createWorkshopUseCase,
      getAllWorkshopsUseCase: getAllWorkshopsUseCase,
      deleteWorkshopUseCase: deleteWorkshopUseCase,
    );
  });

  tearDown(() {
    workshopBloc.close();
  });

  final mockWorkshops = [
    WorkshopEntity(
      id: '1',
      title: 'Beginner Yoga',
      description: 'Basic yoga for beginners',
      address: 'Yoga Studio',
      classroomInfo: 'Room 101',
      mapLocation: '27.7172,85.3240',
      difficultyLevel: 'Beginner',
      price: 50.0,
      discountPrice: 40.0,
      categoryId: 'category1',
      photo: 'https://example.com/photo.jpg',
      modules: [ModuleEntity(name: 'Intro to Yoga', duration: 60)],
    ),
  ];

  group('Workshop Bloc', () {
    blocTest<WorkshopBloc, WorkshopState>(
      'emits [isLoading, workshops loaded] when LoadWorkshops is called',
      build: () {
        when(() => getAllWorkshopsUseCase.call())
            .thenAnswer((_) async => Right(mockWorkshops));
        return workshopBloc;
      },
      act: (bloc) => bloc.add(LoadWorkshops()),
      expect: () => [
        WorkshopState.initial().copyWith(isLoading: true),
        WorkshopState.initial()
            .copyWith(isLoading: false, workshops: mockWorkshops),
      ],
      verify: (_) {
        verify(() => getAllWorkshopsUseCase.call()).called(1);
      },
    );

    blocTest<WorkshopBloc, WorkshopState>(
      'emits [isLoading, error] when LoadWorkshops fails',
      build: () {
        when(() => getAllWorkshopsUseCase.call()).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Error loading workshops')));
        return workshopBloc;
      },
      act: (bloc) => bloc.add(LoadWorkshops()),
      expect: () => [
        WorkshopState.initial().copyWith(isLoading: true),
        WorkshopState.initial()
            .copyWith(isLoading: false, error: 'Error loading workshops'),
      ],
      verify: (_) {
        verify(() => getAllWorkshopsUseCase.call()).called(1);
      },
    );
  });
}
