import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:io_app/main.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Menu test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: new Home(),
          navigatorObservers: [mockObserver],
        ),
      );
    // Test tic-tac-toe button
    expect(find.text('tic-tac-toe'), findsOneWidget);
    await tester.tap(find.text('tic-tac-toe'));
    await tester.pumpAndSettle();
    expect(find.text('Gomoku'), findsOneWidget);
    // Go back
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    // Test dots-and-boxes button
    expect(find.text('dots-and-boxes'), findsOneWidget);
    await tester.tap(find.text('dots-and-boxes'));
    await tester.pumpAndSettle();
    expect(find.text('Dots and Boxes'), findsOneWidget);
    // Go back
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    // Test snakess button
    expect(find.text('snakess'), findsOneWidget);
    await tester.tap(find.text('snakess'));
    await tester.pumpAndSettle();
    expect(find.text('Snakess'), findsOneWidget);
  });
}
