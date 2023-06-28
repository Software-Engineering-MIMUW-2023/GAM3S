import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:io_app/main.dart';

void main() {
  testWidgets('How to play test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new Home())
    );
    await tester.pumpWidget(testWidget);
    expect(find.text('How to play'), findsNothing);

    await tester.tap(find.byIcon(Icons.question_mark_outlined));
    await tester.pump();
    expect(find.text('How to play'), findsOneWidget);
  });
}
