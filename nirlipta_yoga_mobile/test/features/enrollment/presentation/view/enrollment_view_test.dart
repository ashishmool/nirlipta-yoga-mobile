import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/presentation/view/enrollment_view.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/presentation/view_model/enrollment_bloc.dart';

class MockEnrollmentBloc extends MockBloc<EnrollmentEvent, EnrollmentState>
    implements EnrollmentBloc {}

void main() {
  late MockEnrollmentBloc enrollmentBloc;

  setUp(() {
    enrollmentBloc = MockEnrollmentBloc();
    // Mock the initial state of the EnrollmentBloc
    when(() => enrollmentBloc.state).thenReturn(EnrollmentState.initial());
  });

  Widget loadEnrollmentView() {
    return BlocProvider<EnrollmentBloc>(
      create: (context) => enrollmentBloc,
      child: MaterialApp(home: EnrollmentView()),
    );
  }

  testWidgets('check for the text in enrollment ui', (tester) async {
    // Mock the initial state
    when(() => enrollmentBloc.state).thenReturn(EnrollmentState.initial());

    await tester.pumpWidget(loadEnrollmentView());

    // Wait for the widget tree to settle
    await tester.pumpAndSettle();

    // Find the AppBar with the text 'Enrollments'
    final result = find.text('Enrollments');

    // Verify that the AppBar is found
    expect(result, findsOneWidget);
  });

  testWidgets('check for the loading state', (tester) async {
    // Mock the loading state
    when(() => enrollmentBloc.state).thenReturn(
      EnrollmentState(isLoading: true, enrollments: []),
    );

    await tester.pumpWidget(loadEnrollmentView());

    // Wait for the widget tree to settle
    await tester.pumpAndSettle();

    // Find the CircularProgressIndicator
    final result = find.byType(CircularProgressIndicator);

    // Verify that the CircularProgressIndicator is found
    expect(result, findsOneWidget);
  });

  testWidgets('check for the empty state', (tester) async {
    // Mock the empty state
    when(() => enrollmentBloc.state).thenReturn(
      EnrollmentState(isLoading: false, enrollments: []),
    );

    await tester.pumpWidget(loadEnrollmentView());

    // Wait for the widget tree to settle
    await tester.pumpAndSettle();

    // Find the text 'No Enrollments Added Yet'
    final result = find.text('No Enrollments Added Yet');

    // Verify that the text is found
    expect(result, findsOneWidget);
  });
}
