// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:codeedex/main.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Test with user not logged in (should show login screen)
    await tester.pumpWidget(const MyApp(isLoggedIn: false));

    // Verify the app builds without errors
    expect(find.byType(MyApp), findsOneWidget);
  });

  testWidgets('App initialization with logged in user', (WidgetTester tester) async {
    // Build our app with user logged in (should show home screen)
    await tester.pumpWidget(const MyApp(isLoggedIn: true));

    // Verify the app builds without errors
    expect(find.byType(MyApp), findsOneWidget);
  });
}
