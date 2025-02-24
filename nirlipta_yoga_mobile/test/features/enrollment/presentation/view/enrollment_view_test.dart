import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/presentation/view/enrollment_view.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/presentation/view_model/enrollment_bloc.dart';

class MockEnrollmentBloc extends Mock implements EnrollmentBloc {}

void main() {
  late MockEnrollmentBloc enrollmentBloc;

  setUp(() {
    enrollmentBloc = MockEnrollmentBloc();
    when(() => enrollmentBloc.state).thenReturn(EnrollmentState.initial());
    whenListen(
      enrollmentBloc,
      Stream.value(EnrollmentState.initial()), // Provide a valid stream
    );
  });

  Widget loadEnrollmentView() {
    return MaterialApp(
      home: BlocProvider<EnrollmentBloc>.value(
        value: enrollmentBloc,
        child: EnrollmentView(),
      ),
    );
  }

  testWidgets('Displays "No Enrollments Added Yet" when list is empty',
      (tester) async {
    when(() => enrollmentBloc.state).thenReturn(EnrollmentState(
      isLoading: false,
      enrollments: [],
    ));

    await tester.pumpWidget(loadEnrollmentView());
    await tester.pumpAndSettle();

    expect(find.text('No Enrollments Added Yet'), findsOneWidget);
  });
}
