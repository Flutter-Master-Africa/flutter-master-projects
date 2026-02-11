// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:counter_state_app/main.dart';

void main() {
  testWidgets('State Management Learning App loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StateManagementLearningApp());
    await tester.pumpAndSettle();

    // Verify that the main menu screen loads with the title
    expect(find.text('Flutter State Management'), findsOneWidget);
    expect(find.text('Choisissez une approche pour apprendre'), findsOneWidget);

    // Verify that some state management options are displayed
    expect(find.text('setState'), findsOneWidget);
    expect(find.text('Provider'), findsOneWidget);
    expect(find.text('BLoC'), findsOneWidget);
  });
}
