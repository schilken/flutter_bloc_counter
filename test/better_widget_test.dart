import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/better_start_page.dart';
import 'package:flutter_bloc_counter/cubit/connectivity_status_cubit.dart';
import 'package:flutter_bloc_counter/cubit/counter_cubit.dart';
import 'package:flutter_bloc_counter/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Use mocktail package
/// don't pump the whole app, only the screen that is to be tested
class MockConnectivityStatusCubit extends MockCubit<Connection>
    implements ConnectivityStatusCubit {}

void main() {
//  final connectivityMock = ConnectivityMock(binding);
  MockConnectivityStatusCubit mockConnectivityStatusCubit;

  setUpAll(() {
    //     connectivityMock.setup();
    registerFallbackValue(Connection.Available);
//    registerFallbackValue(Connection.Unavailable);
  });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BetterMiniBlocApp());

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

  group('using mocktail', () {
    testWidgets('show error message when connectivity goes down',
        (WidgetTester tester) async {
      mockConnectivityStatusCubit = MockConnectivityStatusCubit();

      when(() => mockConnectivityStatusCubit.state)
          .thenReturn(Connection.Unavailable);
      // Build our app and trigger a frame.
      await tester.pumpWidget(BlocProvider<CounterCubit>(
        create: (BuildContext _) => CounterCubit(),
        child: MaterialApp(
          home: BetterStartPage(
            title: 'dummy',
            connectivityStatusCubit: mockConnectivityStatusCubit,
          ),
        ),
      ));

      await tester.pumpAndSettle();
      expect(find.text('Connection.Unavailable'), findsOneWidget);
      expect(find.text('Connection.Available'), findsNothing);
      expect(find.text('You are offline!'), findsOneWidget);
    });
  });
}
