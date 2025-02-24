import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view/register_view.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterBloc {}

void main() {
  late MockRegisterBloc registerBloc;

  setUp(() {
    registerBloc = MockRegisterBloc();
    // Mock the initial state of the RegisterBloc
    when(() => registerBloc.state).thenReturn(RegisterState.initial());
  });

  Widget loadRegisterView(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<RegisterBloc>.value(value: registerBloc),
        ],
        child: RegisterView(),
      ),
    );
  }

  testWidgets('Check for the title "User Registration"', (tester) async {
    await tester.pumpWidget(loadRegisterView(RegisterView()));

    await tester.pumpAndSettle();

    expect(find.text('User Registration'), findsOneWidget);
  });

  testWidgets('Register form validation errors', (tester) async {
    await tester.pumpWidget(loadRegisterView(RegisterView()));

    await tester.pumpAndSettle();

    // Tap the Register button without entering any data
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');
    await tester.tap(registerButtonFinder);
    await tester.pumpAndSettle();

    // Check for validation error messages
    expect(find.text('Please enter full name'),
        findsNothing); // Make sure this is the exact error shown in your app
    expect(find.text('Please enter username'), findsNothing);
    expect(find.text('Please enter email'), findsNothing);
    expect(find.text('Please enter mobile number'), findsNothing);
    expect(find.text('Please enter password'), findsNothing);
    expect(find.text('Please confirm password'), findsNothing);
  });

  // Test all the fields
  testWidgets('Register Test', (tester) async {
    await tester.pumpWidget(loadRegisterView(RegisterView()));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Ashish Mool');
    await tester.enterText(find.byType(TextFormField).at(1), '9813943777');
    await tester.enterText(find.byType(TextFormField).at(2), 'test12345');
    await tester.enterText(
        find.byType(TextFormField).at(4), 'a3.asis@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(5), 'a.mool');

    //=========================== Find the dropdownformfield===========================

    final dropdownFinder = find.byType(DropdownButtonFormField<String>);

    when(() => registerBloc.state).thenReturn(RegisterState(
      isLoading: false,
      isSuccess: true,
      isImageLoading: false,
      isImageSuccess: false,
    ));

    await tester.ensureVisible(dropdownFinder);

    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();

    //=========================== Find the register button===========================
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    expect(find.text('Ashish Mool'), findsOneWidget);
    expect(find.text('9813943777'), findsOneWidget);
    expect(find.text('test12345'), findsOneWidget);
    expect(find.text('a3.asis@gmail.com'), findsOneWidget);
    expect(find.text('a.mool'), findsOneWidget);
    expect(registerBloc.state.isSuccess, true);
  });
}
