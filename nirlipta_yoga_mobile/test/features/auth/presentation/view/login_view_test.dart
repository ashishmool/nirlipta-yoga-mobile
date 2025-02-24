import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view/login_view.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
    // Mock the initial state of the LoginBloc
    when(() => loginBloc.state).thenReturn(LoginState.initial());
  });

  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: MaterialApp(home: LoginView()),
    );
  }

  testWidgets('check for the text in login ui', (tester) async {
    // Mock the initial state
    when(() => loginBloc.state).thenReturn(LoginState.initial());

    await tester.pumpWidget(loadLoginView());

    // Wait for the widget tree to settle
    await tester.pumpAndSettle();

    // Find the ElevatedButton with the text 'Login'
    final result = find.widgetWithText(ElevatedButton, 'Login');

    // Verify that the button is found
    expect(result, findsOneWidget);
  });

  // Check for the validator error
  testWidgets('Check for the email and password', (tester) async {
    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'a3.asis@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'test12345');

    await tester.tap(find
        .byType(ElevatedButton)
        .first);

    await tester.pumpAndSettle();

    expect(find.text('a3.asis@gmail.com'), findsOneWidget);
    expect(find.text('test12345'), findsOneWidget);
  });

  testWidgets('Check for the validator error', (tester) async {
    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();

    // Enter empty text in both fields
    await tester.enterText(find.byKey(const ValueKey('email')), '');
    await tester.enterText(find.byKey(const ValueKey('password')), '');

    // Tap the login button
    await tester.tap(find
        .byType(ElevatedButton)
        .first);
    await tester.pumpAndSettle(); // Allow UI to rebuild after validation

    // Check for validation error messages
    expect(find.text('Please enter a valid email address'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  // Should show progress indicator when loading
  testWidgets('Login success', (tester) async {
    when(() => loginBloc.state).thenReturn(
        LoginState(isLoading: true, isSuccess: true, isPasswordVisible: false));

    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'a3.asis@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'test12345');

    await tester.tap(find
        .byType(ElevatedButton)
        .first);

    await tester.pumpAndSettle();

    expect(loginBloc.state.isSuccess, true);
  });
}
