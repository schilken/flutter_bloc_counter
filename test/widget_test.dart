// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc_counter/main.dart';
import 'package:flutter_test/flutter_test.dart';
import '../utils/connectivity_mock.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized()
      as TestWidgetsFlutterBinding;

  final connectivityMock = ConnectivityMock(binding);
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MiniBlocApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  group('using connectivity mock', () {
    setUpAll(() {
      connectivityMock.setup();
    });

    testWidgets('show error message when connectivity goes down',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MiniBlocApp());

      // disable internet connection
      connectivityMock.sendPlatformMessageToFramework('none');

      await tester.pumpAndSettle();
      expect(find.text('Connection.Unavailable'), findsOneWidget);
      expect(find.text('Connection.Available'), findsNothing);
      expect(find.text('You are offline!'), findsOneWidget);

      connectivityMock.sendPlatformMessageToFramework('wifi');

      await tester.pumpAndSettle();
      expect(find.text('Connection.Available'), findsOneWidget);
      expect(find.text('You are offline!'), findsNothing);
    });
  });
}
