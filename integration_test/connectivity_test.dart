import 'package:flutter_bloc_counter/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'utils/connectivity_mock.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;
  final connectivityMock = ConnectivityMock(binding);
  binding.defaultTestTimeout = const Timeout(Duration(minutes: 1));

  setUpAll(() {
    connectivityMock.setup();
  });

  testWidgets('connectivity is switchable using connectivityMock',
      (WidgetTester tester) async {
    await tester.pumpWidget(MiniBlocApp()); // Create main app
    await tester.pumpAndSettle();
    expect(find.text('Connection.Available'), findsOneWidget);
    await pause();

    connectivityMock.sendPlatformMessageToFramework('none');

    await tester.pumpAndSettle();
    await pause();
    expect(find.text('Connection.Available'), findsNothing);
    expect(find.text('You are offline!'), findsOneWidget);

    connectivityMock.sendPlatformMessageToFramework('wifi');

    await tester.pumpAndSettle();
    await pause();
    expect(find.text('Connection.Available'), findsOneWidget);
    expect(find.text('You are offline!'), findsNothing);
  });
}

Future<void> pause() async {
  await Future<void>.delayed(Duration(milliseconds: 2000));
}
