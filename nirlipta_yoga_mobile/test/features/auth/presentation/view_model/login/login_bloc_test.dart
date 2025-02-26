import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view/login_view.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/request_otp/request_otp_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/home/presentation/view_model/home_cubit.dart';

// Added mocktail dependency in pubspec.yaml to mock UI

// Mock dependencies
class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockRequestOtpBloc extends Mock implements RequestOtpBloc {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockLoginUserUsecase extends Mock implements LoginUserUsecase {}

void main() {
  late LoginBloc loginBloc;
  late RegisterBloc registerBloc;
  late RequestOtpBloc requestOtpBloc;
  late HomeCubit homeCubit;
  late LoginUserUsecase loginUserUsecase;

  setUp(() {
    registerBloc = MockRegisterBloc();
    requestOtpBloc = MockRequestOtpBloc();
    homeCubit = MockHomeCubit();
    loginUserUsecase = MockLoginUserUsecase();

    loginBloc = LoginBloc(
      registerBloc: registerBloc,
      homeCubit: homeCubit,
      loginUserUsecase: loginUserUsecase,
      requestOtpBloc: requestOtpBloc,
    );
  });

  testWidgets('Email and Password Validation', (WidgetTester tester) async {
    // Wrap the test with the required providers
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields
    final emailField = find.byKey(Key('email'));
    final passwordField = find.byKey(Key('password'));

    // Enter text
    await tester.enterText(emailField, 'ashishmool@gmail.com');
    await tester.enterText(passwordField, 'password@123');

    // Ensure UI updates
    await tester.pump();

    // Verify that the text has been entered correctly
    expect(find.text('ashishmool@gmail.com'), findsOneWidget);
    expect(find.text('password@123'), findsOneWidget);
  });

  testWidgets('Invalid Email and Password Validation',
      (WidgetTester tester) async {
    // Wrap the test with the required providers
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: LoginView(),
        ),
      ),
    );

    // Find text fields
    final emailField = find.byKey(Key('email'));
    final passwordField = find.byKey(Key('password'));
    final loginButton = find.byKey(Key('loginButton'));

    // Enter an invalid email and a short password
    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(passwordField, 'short');

    // Ensure UI updates
    await tester.pump();

    // Tap the login button
    await tester.tap(loginButton);
    await tester.pump();

    // Check for validation messages
    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });
}
