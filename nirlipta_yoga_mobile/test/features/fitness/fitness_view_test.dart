import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nirlipta_yoga_mobile/features/fitness/fitness_view.dart';

void main() {
  testWidgets('Displays Fitness Dashboard screen', (tester) async {
    await tester.pumpWidget(MaterialApp(home: FitnessView()));

    // Check for the app bar title
    expect(find.text('Fitness Dashboard'), findsOneWidget);

    // Check for step count widget
    expect(find.text('STEPS'), findsOneWidget);

    // Check for proximity lock button
    expect(find.text('Activate Lock & Auto Unlock in 5s'), findsOneWidget);
  });
}
