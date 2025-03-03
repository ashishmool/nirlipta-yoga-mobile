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

class MockCreateWorkshopUseCase extends Mock implements CreateWorkshopUseCase {}

class MockGetAllWorkshopsUseCase extends Mock
    implements GetAllWorkshopsUseCase {}

class MockDeleteWorkshopUseCase extends Mock implements DeleteWorkshopUseCase {}

void main() {
  late WorkshopBloc workshopBloc;
  late MockCreateWorkshopUseCase mockCreateWorkshopUseCase;
  late MockGetAllWorkshopsUseCase mockGetAllWorkshopsUseCase;
  late MockDeleteWorkshopUseCase mockDeleteWorkshopUseCase;

  setUp(() {
    mockCreateWorkshopUseCase = MockCreateWorkshopUseCase();
    mockGetAllWorkshopsUseCase = MockGetAllWorkshopsUseCase();
    mockDeleteWorkshopUseCase = MockDeleteWorkshopUseCase();

    workshopBloc = WorkshopBloc(
      createWorkshopUseCase: mockCreateWorkshopUseCase,
      getAllWorkshopsUseCase: mockGetAllWorkshopsUseCase,
      deleteWorkshopUseCase: mockDeleteWorkshopUseCase,
    );
  });

  tearDown(() {
    workshopBloc.close();
  });

  final workshopList = [
    WorkshopEntity(
        id: "1",
        title: 'Yoga Basics',
        price: 20.0,
        difficultyLevel: 'Beginner',
        categoryId: "1",
        modules: []),
    WorkshopEntity(
        id: "2",
        title: 'Advanced Yoga',
        price: 30.0,
        difficultyLevel: 'Advanced',
        categoryId: "2",
        modules: []),
  ];

  group('WorkshopBloc Tests', () {
    test('Initial state is correct', () {
      expect(workshopBloc.state, WorkshopState.initial());
    });

    blocTest<WorkshopBloc, WorkshopState>(
      'emits [loading, loaded] when LoadWorkshops is added and successful',
      build: () {
        when(() => mockGetAllWorkshopsUseCase.call())
            .thenAnswer((_) async => Right(workshopList));
        return workshopBloc;
      },
      act: (bloc) => bloc.add(LoadWorkshops()),
      expect: () => [
        WorkshopState.initial().copyWith(isLoading: true, workshops: []),
        WorkshopState.initial()
            .copyWith(isLoading: false, workshops: workshopList),
      ],
      verify: (_) {
        verify(() => mockGetAllWorkshopsUseCase.call()).called(1);
      },
    );

    blocTest<WorkshopBloc, WorkshopState>(
      'emits [loading, error] when LoadWorkshops fails',
      build: () {
        when(() => mockGetAllWorkshopsUseCase.call()).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Error fetching workshops')));
        return workshopBloc;
      },
      act: (bloc) => bloc.add(LoadWorkshops()),
      expect: () => [
        WorkshopState.initial().copyWith(isLoading: true, workshops: []),
        WorkshopState.initial()
            .copyWith(isLoading: false, error: 'Error fetching workshops'),
      ],
    );
  });
}
