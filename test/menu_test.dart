import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:io_app/main.dart';

void main() {
  testWidgets('Menu test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new Home())
    );
    await tester.pumpWidget(testWidget);
    expect(find.text('tic-tac-toe'), findsOneWidget);
    expect(find.text('dots-and-boxes'), findsOneWidget);
    expect(find.text('snakess'), findsOneWidget);
  });
}
