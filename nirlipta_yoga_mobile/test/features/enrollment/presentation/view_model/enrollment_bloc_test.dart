import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/user_shared_prefs.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/domain/use_case/create_enrollment_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/domain/use_case/delete_enrollment_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/domain/use_case/get_enrollment_by_user_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/domain/use_case/update_enrollment_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/presentation/view_model/enrollment_bloc.dart';

// Mock Use Cases
class MockCreateEnrollmentUseCase extends Mock
    implements CreateEnrollmentUseCase {}

class MockDeleteEnrollmentUseCase extends Mock
    implements DeleteEnrollmentUseCase {}

class MockGetEnrollmentByUserUseCase extends Mock
    implements GetEnrollmentByUserUseCase {}

class MockUpdateEnrollmentUseCase extends Mock
    implements UpdateEnrollmentUseCase {}

class MockUserSharedPrefs extends Mock implements UserSharedPrefs {}

// Fake class for GetEnrollmentByUserParams
class FakeGetEnrollmentByUserParams extends Fake
    implements GetEnrollmentByUserParams {}

void main() {
  late EnrollmentBloc enrollmentBloc;
  late MockCreateEnrollmentUseCase mockCreateEnrollmentUseCase;
  late MockDeleteEnrollmentUseCase mockDeleteEnrollmentUseCase;
  late MockGetEnrollmentByUserUseCase mockGetEnrollmentByUserUseCase;
  late MockUpdateEnrollmentUseCase mockUpdateEnrollmentUseCase;
  late MockUserSharedPrefs mockUserSharedPrefs;

  setUpAll(() {
    // Register fallback values for parameter types
    registerFallbackValue(FakeGetEnrollmentByUserParams());
  });

  setUp(() {
    mockCreateEnrollmentUseCase = MockCreateEnrollmentUseCase();
    mockDeleteEnrollmentUseCase = MockDeleteEnrollmentUseCase();
    mockGetEnrollmentByUserUseCase = MockGetEnrollmentByUserUseCase();
    mockUpdateEnrollmentUseCase = MockUpdateEnrollmentUseCase();
    mockUserSharedPrefs = MockUserSharedPrefs();

    // Mock getUserData to return a valid response
    when(() => mockUserSharedPrefs.getUserData()).thenAnswer(
      (_) async => const Right(['token', 'user_id']),
    );

    enrollmentBloc = EnrollmentBloc(
      createEnrollmentUseCase: mockCreateEnrollmentUseCase,
      deleteEnrollmentUseCase: mockDeleteEnrollmentUseCase,
      getEnrollmentByUserUseCase: mockGetEnrollmentByUserUseCase,
      updateEnrollmentUseCase: mockUpdateEnrollmentUseCase,
      userSharedPrefs: mockUserSharedPrefs,
    );
  });

  tearDown(() {
    enrollmentBloc.close();
  });

  // Test 1: Verify the initial state
  test('Initial state is correct', () {
    final initialState = enrollmentBloc.state;
    print('Initial state: $initialState'); // Debugging print statement

    expect(initialState, EnrollmentState.initial()); // Now matches correctly
  });
}
